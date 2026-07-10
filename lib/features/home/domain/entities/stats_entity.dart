import 'package:job_finder/features/home/domain/entities/sub_entity/suggested_job_entity.dart';
import 'package:job_finder/features/home/domain/entities/sub_entity/total_jobs_entity.dart';

class StatsEntity {
  final bool isSuccess;
  final TotalJobsEntity totalJobs;
  final List<SuggestedJobEntity> suggestedJobs;

  StatsEntity({
    required this.isSuccess,
    required this.totalJobs,
    required this.suggestedJobs,
  });
}
