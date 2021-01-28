import 'package:chatterhub/src/app/locator.dart';
import 'package:chatterhub/src/app/router.gr.dart';
import 'package:chatterhub/src/models/my_post.dart';
import 'package:chatterhub/src/services/firestore_service.dart';
import 'package:chatterhub/src/ui/views/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = getIt<NavigationService>();
  final FirestoreService _firestoreService = getIt<FirestoreService>();
  final DialogService _dialogService = getIt<DialogService>();

  List<MyPost> get posts => _posts;
  List<MyPost> _posts;

  Future fetchPosts() async {
    setBusy(true);
    var postsResults = await _firestoreService.getPostsOnceOff();
    setBusy(false);

    if (postsResults is List<MyPost>) {
      _posts = postsResults;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'Posts Update Failed',
        description: postsResults,
      );
    }
  }

  void listenToPosts() {
    setBusy(true);
    _firestoreService.listenToPostsRealTime().listen((postsData) {
      List<MyPost> updatedPosts = postsData;
      if (updatedPosts != null && updatedPosts.length > 0) {
        _posts = updatedPosts;
        notifyListeners();
      }
      setBusy(false);
    });
  }

// arguments: _posts[index]
  void editPost(int index) {
    _navigationService.navigateTo(
      Routes.createPostView,
      arguments: CreatePostViewArguments(
        edittingPost: _posts[index],
      ),
    );
  }

  Future deletePost(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the post?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      setBusy(true);
      await _firestoreService.deletePost(_posts[index].documentId);
      setBusy(false);
    }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(Routes.createPostView);
    await fetchPosts();
  }
}
