// import 'package:get_it/get_it.dart';
// import 'package:job_finder/core/database/api/dio_client.dart';
// import 'package:job_finder/core/database/api/dio_consumer.dart';
//
// import 'package:job_finder/features/auth/data/data_source/remote_data_source.dart';
// import 'package:job_finder/features/auth/data/repo/auth_repo_impl.dart';
// import 'package:job_finder/features/auth/domain/repo/auth_repo.dart';
// import 'package:job_finder/features/auth/domain/uses_cases/auth_use_case.dart';
// import 'package:job_finder/features/auth/presentation/cubit/auth_cubit.dart';
//
// import 'package:job_finder/features/home/data/data_source/home_remote_data_source.dart';
// import 'package:job_finder/features/home/data/repo/home_repo_impl.dart';
// import 'package:job_finder/features/home/domain/repo/home_repo.dart';
// import 'package:job_finder/features/home/domain/uses_cases/home_jobs_use_case.dart';
// import 'package:job_finder/features/home/presentation/bloc/home_jobs_bloc.dart';
//
// final GetIt sl =
//     GetIt.instance; // sl stands for Service Locator
//
// void setupLocator() {
//   // ==================== 1. Core & Network ====================
//   // نستخدم LazySingleton لكي يتم إنشاء الكائن فقط عند أول استخدام له
//   sl.registerLazySingleton<DioClient>(() => DioClient());
//   sl.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: sl<DioClient>().dio),
//   );
//
//   // ==================== 2. Data Sources ====================
//   // يتم تمرير DioConsumer المحفوظ مسبقاً في sl
//   sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(api: sl()),);
//   sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSource(dioConsumer: sl()),);
//
//   // ==================== 3. Repositories ====================
//   // نُسجل الـ Interface (الـ Abstract Class) ونُرجع الـ Implementation
//   sl.registerLazySingleton<AuthRepo>(
//     () => AuthRepoImpl(remoteDataSource: sl()),
//   );
//   sl.registerLazySingleton<HomeRepo>(
//     () => HomeRepoImpl(homeRemoteDataSource: sl()),
//   );
//
//   // ==================== 4. Use Cases ====================
//   sl.registerLazySingleton<RegisterUseCase>(
//     () => RegisterUseCase(authRepo: sl()),
//   );
//   sl.registerLazySingleton<LoginUserCase>(
//     () => LoginUserCase(authRepo: sl()),
//   );
//   sl.registerLazySingleton<HomeJobsUseCase>(
//     () => HomeJobsUseCase(homeRepo: sl()),
//   );
//
//   // ==================== 5. Blocs & Cubits ====================
//   // الـ Blocs غالباً ما تُسجل كـ Factory لأننا قد نحتاج نسخة جديدة منها إذا تم إغلاق الشاشة
//   sl.registerFactory<AuthCubit>(
//     () => AuthCubit(
//       loginUseCase: sl(),
//       registerUseCase: sl(),
//     ),
//   );
//   sl.registerFactory<HomeJobsBloc>(
//     () => HomeJobsBloc(homeJobsUseCase: sl()),
//   );
// }
