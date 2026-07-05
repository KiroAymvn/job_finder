import 'package:dartz/dartz.dart';
import 'package:job_finder/core/errors/failure.dart';
import 'package:job_finder/core/params/list_all_jobs.dart';
import 'package:job_finder/features/home/domain/entities/home_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure,HomeEntity>> getHomeJobs({required ListAllJobsParams params} );
}