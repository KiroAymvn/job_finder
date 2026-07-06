import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:job_finder/core/database/api/api_consumer.dart';
import 'package:job_finder/core/database/api/dio_consumer.dart';
import 'package:job_finder/core/database/api/end_points.dart';
import 'package:job_finder/core/params/auth_params.dart';
import 'package:job_finder/core/utils/secure_storage_helper.dart';
import 'package:job_finder/features/auth/data/models/user_model.dart';
import 'package:job_finder/features/auth/domain/entities/user_entity.dart';

class AuthRemoteDataSource {
  final DioConsumer api;

  AuthRemoteDataSource({required this.api});

  Future<UserEntity?> register({
    required RegisterParams registerParams,
  }) async {
    final response = await api.post(
       AppEndPoint.register,
      data: {
        "email": registerParams.email,
        "password": registerParams.password,
        "fullName": registerParams.fullName,
        "phoneNumber": registerParams.phoneNumber,
        "address": registerParams.address,
        "gender": registerParams.gender,
        "role": registerParams.role,
      },
    );

    final UserModel userModel = UserModel.fromJson(
      response,
    );
    final secure=await SecureStorageHelper.getInstance();
    secure?.assignData(key: AppSecureKey.token, value: userModel.dataEntity.token);
    secure?.assignData(key: AppSecureKey.userName, value: userModel.dataEntity.name);
    return userModel;
  }

  Future<UserEntity?> login({
    required LoginParams loginParams,
  }) async {
    final response = await api.post(
      AppEndPoint.login,
      data: {
        "email": loginParams.email,
        "password": loginParams.password,
      },
    );
    final UserModel userModel = UserModel.fromJson(
      response,
    );
    final secure=await SecureStorageHelper.getInstance();
    secure?.assignData(key: AppSecureKey.token, value: userModel.dataEntity.token);
    secure?.assignData(key: AppSecureKey.userName, value: userModel.dataEntity.name);
    return userModel;
  }}
