import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 1. Import flutter_bloc
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_finder/core/utils/app_router.dart';

import 'features/onboarding/presentation/state managment/auth_cubit.dart';
// 2. Import your AuthCubit here (تأكد من مسار الملف الصحيح)
// import 'package:job_finder/features/auth/presentation/cubit/auth_cubit.dart';

void main() => runApp(
  DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {

        // 3. Wrap MaterialApp.router with MultiBlocProvider
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(),
            ),
            // يمكنك إضافة المزيد من الـ Providers هنا لاحقاً
            // BlocProvider<AnotherCubit>(create: (context) => AnotherCubit()),
          ],
          child: MaterialApp.router(
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
          ),
        );

      },
    );
  }
}