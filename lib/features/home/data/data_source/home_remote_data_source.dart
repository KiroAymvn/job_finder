import 'package:job_finder/core/database/api/dio_consumer.dart';
import 'package:job_finder/core/database/api/end_points.dart';
import 'package:job_finder/core/params/list_all_jobs.dart';
import 'package:job_finder/features/home/data/models/home_model.dart';
import 'package:job_finder/features/home/domain/entities/home_entity.dart';

class HomeRemoteDataSource {
  final DioConsumer dioConsumer;

  HomeRemoteDataSource({required this.dioConsumer});

  Future<HomeEntity> getJobsData({required ListAllJobsParams params})async{
    final response = await dioConsumer.get(AppEndPoint.listAllJobs,queryParameters: params.toMap());
    return HomeModel.fromMap(response);
  }

}