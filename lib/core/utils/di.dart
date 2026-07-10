import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:job_finder/core/database/api/dio_client.dart';
import 'package:job_finder/core/database/api/dio_consumer.dart';
import 'package:job_finder/features/auth/data/data_source/remote_data_source.dart';
import 'package:job_finder/features/auth/data/repo/auth_repo_impl.dart';
import 'package:job_finder/features/auth/domain/uses_cases/auth_use_case.dart';
import 'package:job_finder/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:job_finder/features/home/data/data_source/home_remote_data_source.dart';
import 'package:job_finder/features/home/data/repo/home_repo_impl.dart';
import 'package:job_finder/features/home/domain/uses_cases/home_jobs_use_case.dart';
import 'package:job_finder/features/home/presentation/bloc/home_jobs_bloc.dart';

// 1. إزالة الأقواس من هنا (هذا هو حل الشاشة الحمراء)
final GetIt sl = GetIt.instance;

Future<void> setUp() async {
  // ==================== 1. Core & Network ====================
  // 2. استخدام registerLazySingleton لأننا نمرر دالة () =>
  sl.registerLazySingleton<DioConsumer>(
        () => DioConsumer(dio: DioClient().dio),
  );

  // ==================== 2. Data Sources ====================
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(api: sl<DioConsumer>()),
  );

  sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSource(dioConsumer: sl<DioConsumer>()),
  );

  // ==================== 3. Repositories ====================
  sl.registerLazySingleton<AuthRepoImpl>(
        () => AuthRepoImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
  );

  sl.registerLazySingleton<HomeRepoImpl>(
        () => HomeRepoImpl(homeRemoteDataSource: sl<HomeRemoteDataSource>()),
  );

  // ==================== 4. Use Cases ====================
  sl.registerLazySingleton<LoginUserCase>(
        () => LoginUserCase(authRepo: sl<AuthRepoImpl>()),
  );

  sl.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(authRepo: sl<AuthRepoImpl>()),
  );

  sl.registerLazySingleton<HomeJobsUseCase>(
        () => HomeJobsUseCase(homeRepo: sl<HomeRepoImpl>()),
  );

  // ==================== 5. Blocs & Cubits ====================
  sl.registerFactory<AuthCubit>(
        () => AuthCubit(
      registerUseCase: sl<RegisterUseCase>(),
      loginUseCase: sl<LoginUserCase>(),
    ),
  );

  sl.registerFactory<HomeJobsBloc>(
        () => HomeJobsBloc(
      homeJobsUseCase: sl<HomeJobsUseCase>(),
    ),
  );
}