import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:job_finder/features/onboarding/presentation/screen/on_bording_screen.dart';
import 'package:job_finder/root.dart';

import '../../features/auth/presentation/screen/login_screen.dart';
import '../../features/auth/presentation/screen/register_screen.dart';
import '../../features/home/presentation/screen/get_job_by_slug_screen.dart';
import '../../features/home/presentation/screen/home_screen.dart';
import '../../features/onboarding/presentation/screen/splash_screen.dart';

abstract class AppRouter {
  static final kSplash = "/";
  static final kOnBoarding = "/OnBoarding";
  static final kRegister = "/register";
  static final kLogin = "/login";

  static final kRoot = "/root";
  static final kGetJobBySlugScreen = "/s";

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: kSplash,
        builder:
            (BuildContext context, GoRouterState state) {
              return const SplashScreen();
            },
      ),
      GoRoute(
        path: kOnBoarding,
        builder:
            (BuildContext context, GoRouterState state) {
          return OnBoardingScreen();
        },
      ),
      GoRoute(
        path: kRegister,
        builder:
            (BuildContext context, GoRouterState state) {
              return const RegisterScreen();
            },
      ),
      GoRoute(
        path: kLogin,
        builder:
            (BuildContext context, GoRouterState state) {
              return const LoginScreen();
            },
      ),
      GoRoute(
        path: kRoot,
        builder:
            (BuildContext context, GoRouterState state) {
              return  Root(userName:state.extra.toString() );
            },
      ),
      GoRoute(
        path: kGetJobBySlugScreen,
        builder:
            (BuildContext context, GoRouterState state) {
              return  GetJobBySlugScreen();
            },
      ),

    ],
  );
}
