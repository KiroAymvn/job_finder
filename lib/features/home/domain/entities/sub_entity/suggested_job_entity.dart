import 'package:job_finder/features/home/domain/entities/sub_entity/suggested_job_company_entity.dart';

class SuggestedJobEntity {
  final String id;
  final String title;
  final SuggestedJobCompanyEntity company;
  final String location;
  final String jobType;
  final String jobLevel;
  final String salaryRange;
  final String createdAt;

  SuggestedJobEntity({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.jobType,
    required this.jobLevel,
    required this.salaryRange,
    required this.createdAt,
  });
}
