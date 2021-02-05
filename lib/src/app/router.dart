import 'package:auto_route/auto_route_annotations.dart';
import 'package:chatterhub/src/ui/views/chathome/chathome_view.dart';
import 'package:chatterhub/src/ui/views/counter/counter_view.dart';
import 'package:chatterhub/src/ui/views/create_post/create_post_view.dart';
import 'package:chatterhub/src/ui/views/group/group_view.dart';
import 'package:chatterhub/src/ui/views/home/home_view.dart';
import 'package:chatterhub/src/ui/views/login/login_view.dart';
import 'package:chatterhub/src/ui/views/signup/signup_view.dart';
import 'package:chatterhub/src/ui/views/startup/startup_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: CounterView),
    MaterialRoute(page: CreatePostView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ChatHomeView),
    MaterialRoute(page: GroupView),
  ],
)
class $Router {}
