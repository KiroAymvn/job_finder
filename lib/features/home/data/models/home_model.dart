import 'package:job_finder/features/home/domain/entities/home_entity.dart';

import '../../domain/entities/sub_entity/user_posted_by_entity.dart';

class HomeModel extends HomeEntity {
  HomeModel({
    required super.id,
    required super.title,
    required super.experience,
    required super.jobLevel,
    required super.jobType,
    required super.location,
    required super.salaryRange,
    required super.slug,
    required super.category,
    required super.createdAt,
    required super.updatedAt,
    required super.isFavorite,
    required super.userPostedByEntity,
  });



  factory HomeModel.fromJson(Map<String, dynamic> map) {
    return HomeModel(
      id: map["id"],
      title: map["title"],
      experience: map["experience"],
      jobLevel: map["experience"],
      jobType: map["experience"],
      location: map["experience"],
      salaryRange: map["experience"],
      slug: map["experience"],
      category: map["experience"],
      createdAt: map["experience"],
      updatedAt: map["experience"],
      isFavorite: map["experience"],
      userPostedByEntity: map["experience"],
    );
  }
}

class UserPostedByModel extends UserPostedByEntity {
  UserPostedByModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.imageUrl,
    required super.role,
  });

  factory UserPostedByModel.fromJson(
    Map<String, dynamic> map,
  ) {
    return UserPostedByModel(
      id: map["id"] ?? "",
      fullName: map["fullName"] ?? "No name",
      email: map["email"] ?? "no email",
      imageUrl: map["imageUrl"] ?? null,
      role: map["role"] ?? "USER",
    );
  }
}
