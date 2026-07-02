import 'package:dartz/dartz.dart';
import 'package:job_finder/core/errors/failure.dart';
import 'package:job_finder/core/params/auth_params.dart';
import 'package:job_finder/features/auth/domain/entities/user_entity.dart';
import 'package:job_finder/features/auth/domain/repo/auth_repo.dart';

class RegisterUseCase{
  final AuthRepo authRepo;

  RegisterUseCase({required this.authRepo});

  Future<Either<Failure,UserEntity>>call({required RegisterParams registerParams}){
    return authRepo.register(registerParams: registerParams);
  }
}