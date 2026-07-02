
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screen/register_screen.dart';
import '../../features/onboarding/presentation/screen/splash_screen.dart';
abstract class AppRouter {
  static final kSplash = "/";
  static final kRegister = "/register"; // مسار جديد

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: kSplash,
        builder: (BuildContext context, GoRouterState state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        path: kRegister,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen(); // إضافة شاشة التسجيل
        },
      ),
    ],
  );
}