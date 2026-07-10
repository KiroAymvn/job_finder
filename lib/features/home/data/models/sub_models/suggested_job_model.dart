import 'package:job_finder/features/home/domain/entities/sub_entity/suggested_job_entity.dart';
import 'package:job_finder/features/home/data/models/sub_models/suggested_job_company_model.dart';

class SuggestedJobModel extends SuggestedJobEntity {
  SuggestedJobModel({
    required super.id,
    required super.title,
    required super.company,
    required super.location,
    required super.jobType,
    required super.jobLevel,
    required super.salaryRange,
    required super.createdAt,
  });

  factory SuggestedJobModel.fromJson(Map<String, dynamic> json) {
    return SuggestedJobModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      company: SuggestedJobCompanyModel.fromJson(
        json['company'] ?? {},
      ),
      location: json['location'] ?? '',
      jobType: json['jobType'] ?? '',
      jobLevel: json['jobLevel'] ?? '',
      salaryRange: json['salaryRange'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
