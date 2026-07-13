import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_finder/core/params/list_all_jobs.dart';
import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/core/utils/app_router.dart';
import 'package:job_finder/features/home/presentation/bloc/home/home_jobs_bloc.dart';
import 'package:job_finder/features/home/presentation/bloc/stats/stats_bloc.dart';

import 'core/utils/di.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/home/presentation/bloc/detailed_job/job_details_cubit.dart';

// 2. Import your AuthCubit here (تأكد من مسار الملف الصحيح)
// import 'package:job_finder/features/auth/presentation/bloc/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
}

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
              create: (context) => sl<AuthCubit>()),
            BlocProvider<HomeScreenBloc>(
              create: (context) =>
                  sl<HomeScreenBloc>()..add(HomeJobsSearchEvent(params: ListAllJobsParams())),
            ),
            BlocProvider<SearchScreenBloc>(
              create: (context) => sl<SearchScreenBloc>(),
            ),
            BlocProvider<JobDetailsCubit>(create: (context) => sl<JobDetailsCubit>()),
            BlocProvider<StatsBloc>(
              lazy: false,
              create: (context) =>
                  sl<StatsBloc>()..add(FetchStatsEvent()),
            ),
            // يمكنك إضافة المزيد من الـ Providers هنا لاحقاً
            // BlocProvider<AnotherCubit>(create: (context) => AnotherCubit()),
          ],
          child: MaterialApp.router(
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.kGreyEE,),
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
