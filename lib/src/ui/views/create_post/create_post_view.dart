import 'package:chatterhub/src/models/my_post.dart';
import 'package:chatterhub/src/ui/shared/ui_helpers.dart';
import 'package:chatterhub/src/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'create_post_view_model.dart';

class CreatePostView extends StatelessWidget {
  final titleController = TextEditingController();
  final MyPost edittingPost;

  CreatePostView({Key key, this.edittingPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePostViewModel>.reactive(
      viewModelBuilder: () => CreatePostViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        titleController.text = edittingPost?.title ?? '';

        // set the editting post
        model.setEdittingPost(edittingPost);
      },
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: !model.isBusy
              ? Icon(Icons.add)
              : CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
          onPressed: () {
            if (!model.isBusy) {
              model.addPost(
                title: titleController.text,
              );
            }
          },
          backgroundColor:
              !model.isBusy ? Theme.of(context).primaryColor : Colors.grey[600],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  verticalSpace(40),
                  Text(
                    'Create Post',
                    style: TextStyle(fontSize: 26),
                  ),
                  verticalSpaceMedium,
                  InputField(
                    placeholder: 'Title',
                    controller: titleController,
                  ),
                  verticalSpaceMedium,
                  Text('Post Image'),
                  verticalSpaceSmall,
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text(
                      'Tap to add post image',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
