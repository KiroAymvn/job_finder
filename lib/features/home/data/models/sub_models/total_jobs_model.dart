import 'package:job_finder/features/home/domain/entities/sub_entity/total_jobs_entity.dart';

class TotalJobsModel extends TotalJobsEntity {
  TotalJobsModel({
    required super.fullTime,
    required super.partTime,
    required super.freelance,
  });

  factory TotalJobsModel.fromJson(Map<String, dynamic> json) {
    return TotalJobsModel(
      fullTime: json['fullTime'] ?? 0,
      partTime: json['partTime'] ?? 0,
      freelance: json['freelance'] ?? 0,
    );
  }
}
