import 'package:job_finder/core/database/api/api_consumer.dart';
import 'package:job_finder/core/database/api/dio_consumer.dart';
import 'package:job_finder/core/database/api/end_points.dart';
import 'package:job_finder/core/params/auth_params.dart';
import 'package:job_finder/features/auth/domain/entities/user_entity.dart';

class RemoteDataSource {
  final DioConsumer api;
  RemoteDataSource({required this.api});
  Future<UserEntity?> register({required RegisterParams registerParams})async{
    final response =await api.post(AppEndPoint.register,queryParameters: {
      "email": registerParams.email,
      "password": registerParams.password,
      "fullName": registerParams.fullName,
      "phoneNumber": registerParams.phoneNumber,
      "address": registerParams.address,
      "gender": registerParams.gender,
      "role": registerParams.role
    });

    final UserEntity userEntity= UserEntity.fromMap(response);
    return userEntity;
  }

}