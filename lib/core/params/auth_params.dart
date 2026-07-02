abstract class AuthParams {
  final String email;
  final String password;

  AuthParams({required this.email, required this.password});
}

class loginParams extends AuthParams {
  loginParams({
    required super.email,
    required super.password,
  });
}

class RegisterParams extends AuthParams {
  RegisterParams({
    required super.email,
    required super.password,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.gender,
    required this.role,
  });

  final String fullName;
  final String phoneNumber;
  final String address;
  final String gender;
  final String role;
}
