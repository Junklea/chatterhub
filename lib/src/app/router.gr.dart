// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/counter/counter_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String startupView = '/';
  static const String counterView = '/counter-view';
  static const all = <String>{
    startupView,
    counterView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.counterView, page: CounterView),
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
    CounterView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CounterView(),
        settings: data,
      );
    },
  };
}
