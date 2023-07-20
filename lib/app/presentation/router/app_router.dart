import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../ui/aboutus/about_us_view.dart';
import '../ui/main/main_view.dart';
import '../ui/splash/splash_view.dart';
import 'app_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(routes: [
    GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext ctx, GoRouterState state) {
          return const SplashView();
        }),
    GoRoute(
        path: AppRoutes.main,
        builder: (BuildContext ctx, GoRouterState state) {
          return const MainView();
        }),
    GoRoute(
        path: AppRoutes.aboutUs,
        builder: (BuildContext ctx, GoRouterState state) {
          return const AboutUsView();
        }),
  ]);
}
