import 'package:job_finder/features/home/data/models/sub_models/home_data_model.dart';
import 'package:job_finder/features/home/data/models/sub_models/user_posted_by_model.dart';
import 'package:job_finder/features/home/domain/entities/home_entity.dart';
import 'package:job_finder/features/home/domain/entities/sub_entity/home_data_entity.dart';

class JobDetailsEntity extends HomeDataEntity {
  final String description;
  final List<String> skills;
  final List<String> responsibilities;
  final List<String> requirements;
  final List<String> benefits;

  JobDetailsEntity({
    required super.id,
    required super.title,
    required super.experience,
    required super.jobLevel,
    required super.jobType,
    required super.location,
    required super.salaryRange,
    required super.slug,
 //   required super.category,
    required super.createdAt,
    required super.updatedAt,
    required super.isFavorite,
    required super.userPostedByEntity,

    required this.description,
    required this.skills,
    required this.responsibilities,
    required this.requirements,
    required this.benefits,
  });
}


