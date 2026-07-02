import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:job_finder/core/database/api/dio_consumer.dart';
import 'package:job_finder/core/errors/failure.dart';
import 'package:job_finder/core/params/auth_params.dart';
import 'package:job_finder/features/auth/data/data_source/remote_data_source.dart';
import 'package:job_finder/features/auth/data/repo/auth_repo_impl.dart';
import 'package:job_finder/features/auth/domain/entities/user_entity.dart';
import 'package:job_finder/features/auth/domain/uses_cases/auth_use_case.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> registerEitherFailureOrUser({
    required RegisterParams registerParams,
  }) async {
    emit(AuthLoading());
    final failureOrUser = await RegisterUseCase(
      authRepo: AuthRepoImpl(
        remoteDataSource: RemoteDataSource(
          api: DioConsumer(dio: Dio()),
        ),
      ),
    ).call(registerParams: registerParams);
    failureOrUser.fold((failure) {
      emit(AuthFailed(errorMessage: failure.errMessage));
    }, (user){emit(AuthSuccess(userEntity: user));});
  }
}
