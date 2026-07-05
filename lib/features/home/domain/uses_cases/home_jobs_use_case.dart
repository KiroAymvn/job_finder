import 'package:dartz/dartz.dart';
import 'package:job_finder/core/errors/failure.dart';
import 'package:job_finder/core/params/list_all_jobs.dart';
import 'package:job_finder/features/home/domain/entities/home_entity.dart';
import 'package:job_finder/features/home/domain/repo/home_repo.dart';

class HomeJobsUseCase {
  final HomeRepo homeRepo;

  HomeJobsUseCase({required this.homeRepo});

  Future<Either<Failure, HomeEntity>> call(
      {required ListAllJobsParams params}) async {
    return homeRepo.getHomeJobs(params: params);
  }
}
