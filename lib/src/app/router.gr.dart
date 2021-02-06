// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/my_chatroom.dart';
import '../ui/views/chathome/chathome_view.dart';
import '../ui/views/group/group_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/signup/signup_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String startupView = '/';
  static const String signUpView = '/sign-up-view';
  static const String loginView = '/login-view';
  static const String chatHomeView = '/chat-home-view';
  static const String groupView = '/group-view';
  static const all = <String>{
    startupView,
    signUpView,
    loginView,
    chatHomeView,
    groupView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.chatHomeView, page: ChatHomeView),
    RouteDef(Routes.groupView, page: GroupView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartupView(),
        settings: data,
      );
    },
    SignUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    ChatHomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ChatHomeView(),
        settings: data,
      );
    },
    GroupView: (data) {
      final args = data.getArgs<GroupViewArguments>(
        orElse: () => GroupViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => GroupView(
          key: args.key,
          group: args.group,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// GroupView arguments holder class
class GroupViewArguments {
  final Key key;
  final MyChatRoom group;
  GroupViewArguments({this.key, this.group});
}
