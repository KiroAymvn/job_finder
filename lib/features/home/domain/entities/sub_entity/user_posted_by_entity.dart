
class UserPostedByEntity {
  final String id;
  final String fullName;
  final String email;
  final String? imageUrl;
  final Role role;

  UserPostedByEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.imageUrl,
    required this.role,
  });
}

enum Role { ADMIN, USER }
