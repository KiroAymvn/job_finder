import 'package:job_finder/features/home/domain/entities/stats_entity.dart';
import 'package:job_finder/features/home/data/models/sub_models/total_jobs_model.dart';
import 'package:job_finder/features/home/data/models/sub_models/suggested_job_model.dart';

class StatsModel extends StatsEntity {
  StatsModel({
    required super.isSuccess,
    required super.totalJobs,
    required super.suggestedJobs,
  });

  factory StatsModel.fromMap(Map<String, dynamic> map) {
    final data = map['data'] as Map<String, dynamic>? ?? {};
    return StatsModel(
      isSuccess: map['success'] ?? false,
      totalJobs: TotalJobsModel.fromJson(
        data['totalJobs'] as Map<String, dynamic>? ?? {},
      ),
      suggestedJobs: (data['suggestedJobs'] as List<dynamic>? ?? [])
          .map((e) => SuggestedJobModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
