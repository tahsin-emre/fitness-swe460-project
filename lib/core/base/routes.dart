import 'package:fitness/views/main/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splash = '/';
  static const String auth = '/auth';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings rs) {
    Widget page = Container();
    switch (rs.name) {
      case splash:
        page = const SplashView();
      case auth:
        page = Container();
      case home:
        page = Container();
      default:
        page = Container();
    }
    return MaterialPageRoute(builder: (_) => page, settings: rs);
  }
}
