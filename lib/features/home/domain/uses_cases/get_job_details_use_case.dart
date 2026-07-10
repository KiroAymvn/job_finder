import 'package:dartz/dartz.dart';
import 'package:job_finder/core/errors/failure.dart';
import 'package:job_finder/features/home/domain/entities/job_details_entity.dart';
import 'package:job_finder/features/home/domain/repo/home_repo.dart';

class GetJobDetailsUseCase {
  final HomeRepo homeRepo;

  GetJobDetailsUseCase({required this.homeRepo});

  Future<Either<Failure, JobDetailsEntity>> call({required String jobSlug}) async {
    return await homeRepo.getJobDetails(jobSlug: jobSlug);
  }
}