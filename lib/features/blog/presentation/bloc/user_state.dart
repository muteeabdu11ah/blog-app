part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}
final class UserFailure extends UserState {
    final String error;

  UserFailure({required this.error});

}
final class UserNameFetchSucess extends UserState {
  final String UserName;

  UserNameFetchSucess(this.UserName);
  
}
