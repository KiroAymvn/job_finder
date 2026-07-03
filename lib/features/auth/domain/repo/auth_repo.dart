import 'package:dartz/dartz.dart';
import 'package:job_finder/core/errors/failure.dart';
import 'package:job_finder/core/params/auth_params.dart';
import 'package:job_finder/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure,UserEntity>> register({required RegisterParams registerParams});
  Future<Either<Failure,UserEntity>> login({required LoginParams loginParams});

}