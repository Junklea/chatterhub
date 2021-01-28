// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/my_post.dart';
import '../ui/views/chathome/chathome_view.dart';
import '../ui/views/counter/counter_view.dart';
import '../ui/views/create_post/create_post_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/signup/signup_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String startupView = '/';
  static const String signUpView = '/sign-up-view';
  static const String loginView = '/login-view';
  static const String counterView = '/counter-view';
  static const String createPostView = '/create-post-view';
  static const String homeView = '/home-view';
  static const String chatHomeView = '/chat-home-view';
  static const all = <String>{
    startupView,
    signUpView,
    loginView,
    counterView,
    createPostView,
    homeView,
    chatHomeView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.counterView, page: CounterView),
    RouteDef(Routes.createPostView, page: CreatePostView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.chatHomeView, page: ChatHomeView),
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
    CounterView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CounterView(),
        settings: data,
      );
    },
    CreatePostView: (data) {
      final args = data.getArgs<CreatePostViewArguments>(
        orElse: () => CreatePostViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreatePostView(
          key: args.key,
          edittingPost: args.edittingPost,
        ),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    ChatHomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ChatHomeView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// CreatePostView arguments holder class
class CreatePostViewArguments {
  final Key key;
  final MyPost edittingPost;
  CreatePostViewArguments({this.key, this.edittingPost});
}
