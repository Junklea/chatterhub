import 'package:chatterhub/src/app/router.gr.dart';
import 'package:chatterhub/src/services/authentication_service.dart';
import 'package:chatterhub/src/ui/views/startup/startup_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// class StartupView extends StatelessWidget {
//   const StartupView({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (BuildContext context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           User user = snapshot.data;
//           if (user == null) {
//             NavigationService().navigateTo(Routes.signUpView);
//           }
//           NavigationService().navigateTo(Routes.chatHomeView);
//         } else {
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

class StartupView extends StatelessWidget {
  const StartupView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () => model.handleStartUpLogic(),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Color(0xff19c7c1)),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (model) =>
          Future.delayed(Duration.zero, () => model.handleStartUpLogic()),
    );
  }
}
