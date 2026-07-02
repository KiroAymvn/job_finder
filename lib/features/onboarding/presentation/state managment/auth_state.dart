part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthSuccess extends AuthState {
  final UserEntity userEntity;
  AuthSuccess({required this.userEntity});

}
final class AuthFailed extends AuthState {
  final String errorMessage;
  AuthFailed({required this.errorMessage});

}
