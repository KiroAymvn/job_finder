import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:job_finder/core/errors/exceptions.dart';
import 'package:job_finder/core/errors/failure.dart';
import 'package:job_finder/core/params/auth_params.dart';
import 'package:job_finder/core/storage/app_cache_key.dart';
import 'package:job_finder/core/storage/secure_storage_helper.dart';
import 'package:job_finder/core/storage/shared_pref.dart';
import 'package:job_finder/features/auth/data/data_source/remote_data_source.dart';
import 'package:job_finder/features/auth/data/models/user_model.dart';
import 'package:job_finder/features/auth/domain/entities/user_entity.dart';
import 'package:job_finder/features/auth/domain/repo/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/di.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorageHelper secureStorageHelper;
  final SharedPref sharedPref;

  AuthRepoImpl({
    required this.remoteDataSource,
    required this.sharedPref,
    required this.secureStorageHelper,
  });

  @override
  Future<Either<Failure, UserEntity>> register({
    required RegisterParams registerParams,
  }) async {
    try {
      final userEntity = await remoteDataSource.register(
        registerParams: registerParams,
      );
      await onAuthCache(userEntity);
      return right(userEntity!);
    } on ServerException catch (e) {
      return left(Failure(errMessage: e.errorModel.errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required LoginParams loginParams,
  }) async {
    try {
      final UserEntity? userEntity = await remoteDataSource.login(
        loginParams: loginParams,
      );
      await onAuthCache(userEntity);
      return right(userEntity!);
    } on ServerException catch (e) {
      return left(Failure(errMessage: e.errorModel.errorMessage));
    }
  }

  Future<void> onAuthCache(UserEntity? userEntity) async {
    await Future.wait([
      secureStorageHelper.write(
        key: AppCacheKey.token,
        value: userEntity!.dataEntity.token,
      ),
      sharedPref.setString(
        key: AppCacheKey.userName,
        value: userEntity.dataEntity.name,
      ),
      sharedPref.setBool(key: AppCacheKey.isLogged, value: true),
    ]);
  }
}
