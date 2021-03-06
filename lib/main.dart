import 'package:chatterhub/src/app/locator.dart';
import 'package:chatterhub/src/app/router.gr.dart' as lol;
import 'package:chatterhub/src/ui/setup_dialog_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupDialogUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatterHub',
      onGenerateRoute: lol.Router(),
      navigatorKey: StackedService.navigatorKey,
    );
  }
}

// flutter pub run build_runner build --delete-conflicting-outputs
