import 'package:chatterhub/src/app/locator.dart';
import 'package:chatterhub/src/models/my_post.dart';
import 'package:chatterhub/src/services/firestore_service.dart';
import 'package:chatterhub/src/ui/views/base_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = getIt<FirestoreService>();
  final DialogService _dialogService = getIt<DialogService>();
  final NavigationService _navigationService = getIt<NavigationService>();

  MyPost _edittingPost;

  void setEdittingPost(MyPost post) {
    _edittingPost = post;
  }

  bool get _editting => _edittingPost != null;

  Future addPost({@required String title}) async {
    setBusy(true);
    var result;
    if (!_editting) {
      result = await _firestoreService
          .addPost(MyPost(title: title, userId: currentUser.id));
    } else {
      result = await _firestoreService.updatePost(MyPost(
        title: title,
        userId: _edittingPost.userId,
        documentId: _edittingPost.documentId,
      ));
    }
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not add Post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }

    _navigationService.back();
  }
}
