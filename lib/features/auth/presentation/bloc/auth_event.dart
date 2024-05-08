part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignup extends AuthEvent{
  final String email;
  final String name;
  final String password;

  AuthSignup({required this.email, required this.name, required this.password});
}

final class AuthLogIn extends AuthEvent{
  final String email;
  final String password;

  AuthLogIn({required this.email,  required this.password});
}

final class AuthIsUserLoggedIn extends AuthEvent{
  
}

final class AuthUserLogOut extends AuthEvent{}