import 'package:dartz/dartz.dart';
import 'package:job_finder/core/errors/exceptions.dart';
import 'package:job_finder/core/errors/failure.dart';
import 'package:job_finder/core/params/auth_params.dart';
import 'package:job_finder/core/utils/secure_storage_helper.dart';
import 'package:job_finder/features/auth/data/data_source/remote_data_source.dart';
import 'package:job_finder/features/auth/data/models/user_model.dart';
import 'package:job_finder/features/auth/domain/entities/user_entity.dart';
import 'package:job_finder/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final RemoteDataSource remoteDataSource;

  AuthRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> register({
    required RegisterParams registerParams,
  }) async {
    try {
      final userEntity = await remoteDataSource.register(
        registerParams: registerParams,
      );
      final secureStorage=await SecureStorageHelper.getInstance();
      secureStorage?.assignData(key: "token", value: userEntity!.dataEntity.token);
      return right(userEntity!);
    } on ServerException catch (e) {
      return left(Failure(errMessage: e.errorModel.errorMessage));
    }
  }
}
