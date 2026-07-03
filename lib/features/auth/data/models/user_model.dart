// data/models/user_model.dart

import '../../domain/entities/user_entity.dart';
class UserModel extends UserEntity {
  const UserModel({
    required super.success,
    required super.message,
    required super.timeStamp,
    required super.dataEntity,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      timeStamp: json['timestamp'] ?? '',
      // استدعاء fromJson الخاص بالـ Data Model
      dataEntity: UserDataModel.fromJson(json['data'] ?? {}),
    );
  }
}

class UserDataModel extends UserDataEntity {
  const UserDataModel({
    required super.token,
    required super.id,
    required super.email,
    required super.name,
    required super.isCompleted,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      token: json['token'] ?? '',
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      // الحل هنا: تحقق من name أولاً، وإن لم تجده استخدم fullName
      name: json['name'] ?? json['fullName'] ?? 'Unknown User',
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}

