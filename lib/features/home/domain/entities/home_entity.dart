import 'package:job_finder/features/home/domain/entities/sub_entity/user_posted_by_entity.dart';

class HomeEntity {
  final String id;
  final String title;
  final String experience;
  final String jobLevel;
  final String jobType;
  final String location;
  final String salaryRange;
  final String slug;
  final String? category;
  final String createdAt;
  final String updatedAt;
  final bool isFavorite;
  final UserPostedBy userPostedBy;

  HomeEntity({
    required this.id,
    required this.title,
    required this.experience,
    required this.jobLevel,
    required this.jobType,
    required this.location,
    required this.salaryRange,
    required this.slug,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.isFavorite,
    required this.userPostedBy,
  });
}
