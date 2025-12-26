part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthCheckRequested extends AuthEvent {}

final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  AuthLoginRequested({required this.email, required this.password});
}

final class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String? name;
  AuthSignUpRequested({required this.email, required this.password, this.name});
}

final class AuthLogoutRequested extends AuthEvent {}

final class AuthUpdateProfileRequested extends AuthEvent {
  final UserEntity user;
  AuthUpdateProfileRequested(this.user);
}

final class AuthDeleteAccountRequested extends AuthEvent {}
