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
    String jobTypeConvert({required String jobType}){
      if (jobType=="FULL_TIME"){
        return "Full Time";
      }else if (jobType=="PART_TIME"){
        return "Part Time";
      }
      else if (jobType=="CONTRACT"){
        return "Contract";
      }
      else if (jobType=="INTERNSHIP"){
        return "Internship";
      }
      else {
        return jobType;
      }
    }
    String jobLevelConvert({required String jobLevel}) {
      switch (jobLevel) {
        case "ENTRY_LEVEL":
          return "Entry Level";
        case "MID_LEVEL":
          return "Mid Level";
        case "SENIOR_LEVEL":
          return "Senior Level";
        case "EXECUTIVE":
          return "Executive";
        default:
          return jobLevel;
      }
    }
    return SuggestedJobModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      company: SuggestedJobCompanyModel.fromJson(
        json['company'] ?? {},
      ),
      location: json['location'] ?? '',
      jobLevel: jobLevelConvert(jobLevel: json["jobLevel"]) ?? '',
      jobType: jobTypeConvert(jobType: json["jobType"])?? '',
      salaryRange: json['salaryRange'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
