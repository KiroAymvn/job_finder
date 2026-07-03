
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screen/login_screen.dart';
import '../../features/auth/presentation/screen/register_screen.dart';
import '../../features/onboarding/presentation/screen/splash_screen.dart';
abstract class AppRouter {
  static final kSplash = "/";
  static final kRegister = "/register";
  static final kLogin = "/login";

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: kSplash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: kRegister,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: kLogin,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
    ],
  );
}