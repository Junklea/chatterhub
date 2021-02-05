import 'package:chatterhub/src/models/my_chatroom.dart';
import 'package:chatterhub/src/ui/shared/ui_helpers.dart';
import 'package:chatterhub/src/ui/views/group/group_viewmodel.dart';
import 'package:chatterhub/src/ui/widgets/chat_message.dart';
import 'package:chatterhub/src/ui/widgets/message_form.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class GroupView extends StatelessWidget {
  final MyChatRoom group;

  const GroupView({Key key, this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GroupViewModel>.reactive(
      viewModelBuilder: () => GroupViewModel(),
      onModelReady: (model) => Future.delayed(
        Duration.zero,
        () => model.listenToMessages(group.documentId),
      ),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: null,
          title: Text(group.title),
        ),
        backgroundColor: Colors.white,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Theme.of(context).primaryColor,
        //   child: !model.isBusy ? Icon(Icons.add) : CircularProgressIndicator(),
        //   onPressed: () => {},
        // ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpaceSmall,
              Expanded(
                child: model.messages != null
                    ? ListView.builder(
                        reverse: true,
                        itemCount: model.messages.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => {},
                          child: ChatMessage(
                            index: index,
                            data: model.messages[index].toMap(),
                            showAvatar: true,
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
              ),
              Container(
                child: MessageForm(
                  onSubmit: (value) {
                    model.addMessageToCurrentGroup(group.documentId, value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
