import 'dart:core';

class UserEntity {
  final bool success;
  final String message;
  final String timeStamp;
  final UserDataEntity dataEntity;

  UserEntity({
    required this.success,
    required this.message,
    required this.timeStamp,
    required this.dataEntity,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      success: map['success'] as bool,
      message: map['message'] as String,
      timeStamp: map['timestamp'] as String,
      dataEntity: UserDataEntity.fromJson(map["data"]),
    );
  }
}

class UserDataEntity {
  final String token;
  final String id;
  final String email;
  final String fullName;
  final bool isCompleted;

  UserDataEntity({
    required this.token,
    required this.id,
    required this.email,
    required this.fullName,
    required this.isCompleted,
  });

  factory UserDataEntity.fromJson(
    Map<String, dynamic> map,
  ) {
    return UserDataEntity(
      token: map['token'] as String,
      id: map['id'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }
}
