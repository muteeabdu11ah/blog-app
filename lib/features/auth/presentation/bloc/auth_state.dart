part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


final class AuthLoading extends AuthState {}

final class AuthSucess extends AuthState {

  final UserData uid;

   AuthSucess(this.uid);
}

final class AuthFailure extends AuthState {

  final String message;

  AuthFailure(this.message);
}

final class AuthSent extends AuthState {

  final String message = 'Email Sent Sucessfully';
}
