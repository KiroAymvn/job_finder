// domain/entities/user_entity.dart

// الكيان الذي يمثل الاستجابة بالكامل (Response Wrapper)
class UserEntity {
  final bool success;
  final String message;
  final String timeStamp;
  final UserDataEntity dataEntity;

  const UserEntity({
    required this.success,
    required this.message,
    required this.timeStamp,
    required this.dataEntity,
  });
}

class UserDataEntity {
  final String token;
  final String id;
  final String email;
  final String name; // توحيد المتغير هنا
  final bool isCompleted;

  const UserDataEntity({
    required this.token,
    required this.id,
    required this.email,
    required this.name,
    required this.isCompleted,
  });
}
