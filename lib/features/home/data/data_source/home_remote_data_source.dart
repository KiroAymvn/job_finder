import 'package:job_finder/core/database/api/dio_consumer.dart';
import 'package:job_finder/core/database/api/end_points.dart';
import 'package:job_finder/core/params/list_all_jobs.dart';
import 'package:job_finder/features/home/data/models/home_model.dart';
import 'package:job_finder/features/home/data/models/job_detail_model.dart';
import 'package:job_finder/features/home/data/models/stats_model.dart';
import 'package:job_finder/features/home/domain/entities/home_entity.dart';
import 'package:job_finder/features/home/domain/entities/job_details_entity.dart';
import 'package:job_finder/features/home/domain/entities/stats_entity.dart';

class HomeRemoteDataSource {
  final DioConsumer dioConsumer;

  HomeRemoteDataSource({required this.dioConsumer});

  Future<HomeEntity> getJobsData({required ListAllJobsParams params})async{
    final response = await dioConsumer.get(AppEndPoint.listAllJobs,queryParameters: params.toMap());
    return HomeModel.fromMap(response);
  }
  Future<JobDetailsEntity>getJobDetails({required String jobSlug})async{
    final res=await dioConsumer.get("${AppEndPoint.getJobDetails}/$jobSlug");
    return JobDetailsModel.fromJson(res["data"]);
  }

  Future<StatsEntity> getStats() async {
    final response = await dioConsumer.get(AppEndPoint.states);
    return StatsModel.fromMap(response);
  }

}