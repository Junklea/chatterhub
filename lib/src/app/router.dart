import 'package:auto_route/auto_route_annotations.dart';
import 'package:chatterhub/src/ui/views/counter/counter_view.dart';
import 'package:chatterhub/src/ui/views/startup/startup_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: CounterView),
  ],
)
class $Router {}
