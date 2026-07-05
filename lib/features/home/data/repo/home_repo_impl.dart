import 'package:dartz/dartz.dart';
import 'package:job_finder/core/errors/exceptions.dart';
import 'package:job_finder/core/errors/failure.dart';
import 'package:job_finder/core/params/list_all_jobs.dart';
import 'package:job_finder/features/home/data/data_source/home_remote_data_source.dart';
import 'package:job_finder/features/home/domain/entities/home_entity.dart';
import 'package:job_finder/features/home/domain/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, HomeEntity>> getHomeJobs({
    required ListAllJobsParams params,
  })async {
    try{
      final HomeEntity homeEntity=await homeRemoteDataSource.getJobsData(params: params);
      return right(homeEntity);
    }on ServerException catch(e){
      return left(Failure(errMessage: e.errorModel.errorMessage));
    }

  }
}
