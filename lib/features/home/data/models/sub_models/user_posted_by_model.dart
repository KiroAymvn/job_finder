import '../../../domain/entities/sub_entity/user_posted_by_entity.dart';

class UserPostedByModel extends UserPostedByEntity {
  UserPostedByModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.imageUrl,
    required super.role,
  });

  factory UserPostedByModel.fromJson(Map<String, dynamic> json) {
    return UserPostedByModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['imageUrl'], // تركه يقبل Null لأن صورته قد تكون غير موجودة
      role: json['role'] ?? '',
    );
  }
}