import 'package:job_finder/features/home/data/models/sub_models/user_posted_by_model.dart';

import '../../domain/entities/job_details_entity.dart';

class JobDetailsModel extends JobDetailsEntity {
  JobDetailsModel({
    required super.id,
    required super.title,
    required super.experience,
    required super.jobLevel,
    required super.jobType,
    required super.location,
    required super.salaryRange,
    required super.slug,
   // required super.category,
    required super.createdAt,
    required super.updatedAt,
    required super.isFavorite,
    required super.userPostedByEntity,

    required super.description,
    required super.skills,
    required super.responsibilities,
    required super.requirements,
    required super.benefits,
  });

  factory JobDetailsModel.fromJson(Map<String, dynamic> map) {
    return JobDetailsModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      slug: map['slug'] ?? '',
      location: map['location'] ?? '',
      experience: map['experience'] ?? '',
      jobType: map['jobType'] ?? '',
      jobLevel: map['jobLevel'] ?? '',
      salaryRange: map['salaryRange'] ?? '',
    //  category: map['category']??null,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      isFavorite: map['isFavorite'] ?? false,

      userPostedByEntity: UserPostedByModel.fromJson(map['postedBy'] ?? {}),

      description: map['description'] ?? '',

      // 4. الطريقة الآمنة جداً لتحويل قوائم النصوص (List<String>)
      skills: List<String>.from(map['skills'] ?? []),
      responsibilities: List<String>.from(map['responsibilities'] ?? []),
      requirements: List<String>.from(map['requirements'] ?? []),
      benefits: List<String>.from(map['benefits'] ?? []),
    );
  }
}