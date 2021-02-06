import 'package:chatterhub/src/ui/shared/ui_helpers.dart';
import 'package:chatterhub/src/ui/views/chathome/chathome_viewmodel.dart';
import 'package:chatterhub/src/ui/widgets/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChatHomeView extends StatelessWidget {
  const ChatHomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatHomeViewModel>.reactive(
      viewModelBuilder: () => ChatHomeViewModel(),
      onModelReady: (model) =>
          Future.delayed(Duration.zero, () => model.listenToChatRooms()),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: null,
          title: Text("ChatterHub"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              tooltip: 'Sign Out',
              onPressed: () {
                model.signOut();
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: !model.isBusy ? Icon(Icons.add) : CircularProgressIndicator(),
          onPressed: () {
            model.addGroup();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpaceSmall,
              Expanded(
                child: model.chatRooms != null
                    ? ListView.builder(
                        itemCount: model.chatRooms.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => {},
                          child: ChatItem(
                            chatRoom: model.chatRooms[index],
                            goToGroup: model.goToGroup,
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
            ],
          ),
        ),
      ),
    );
  }
}
