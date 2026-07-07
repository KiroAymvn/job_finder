import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:job_finder/core/database/api/dio_client.dart';
import 'package:job_finder/core/database/api/dio_consumer.dart';
import 'package:job_finder/core/errors/failure.dart';
import 'package:job_finder/core/params/auth_params.dart';
import 'package:job_finder/features/auth/data/data_source/remote_data_source.dart';
import 'package:job_finder/features/auth/data/repo/auth_repo_impl.dart';
import 'package:job_finder/features/auth/domain/entities/user_entity.dart';
import 'package:job_finder/features/auth/domain/uses_cases/auth_use_case.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../shared/scaffold_message.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.registerUseCase, required this.loginUseCase}) : super(AuthInitial());
  final RegisterUseCase registerUseCase;
  final LoginUserCase loginUseCase;
  Future<void> registerEitherFailureOrUser({
    required RegisterParams registerParams,
  }) async {
    emit(AuthLoading());
    final failureOrUser = await registerUseCase.call(registerParams: registerParams);
    failureOrUser.fold(
      (failure) {
        emit(AuthFailed(errorMessage: failure.errMessage));
      },
      (user) {
        emit(AuthSuccess(userEntity: user));
      },
    );
  }

  Future<void> loginFaileOrSuccess({
    required LoginParams loginParams,
  }) async {
    emit(AuthLoading());
    final failOrUser = await loginUseCase.call(loginParams: loginParams);
    failOrUser.fold(
      (failure) {
        emit(AuthFailed(errorMessage: failure.errMessage));
      },
      (user) {
        emit(AuthSuccess(userEntity: user));
      },
    );
  }


  void onSuccessAuth(BuildContext context,{required String message,required String userName}){
    scaffoldMessengerError(
      context,
      message,
      color: AppColors.kPrimary,
    );
    GoRouter.of(context).pushReplacement("/root",extra: userName);
  }

  void onFailureAuth(BuildContext context,{required String message,}){
    scaffoldMessengerError(
      context,
      message,
      color: AppColors.kPrimary,
    );
  }
}
