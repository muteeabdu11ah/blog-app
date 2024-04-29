import 'package:fpdart/src/either.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/core/usecase/usecase.dart';
import 'package:fyp/features/auth/domain/entities/user.dart';
import 'package:fyp/features/auth/domain/repository/auth_repository.dart';

class UserSignIn implements usecase<UserData, UserLogInParams> {
  final AuthRepository authRepository;

  UserSignIn(this.authRepository);
  @override
  Future<Either<Failure, UserData>> call(UserLogInParams params) async {
   return await authRepository.logInwithEmailPassword(
     email: params.email, password: params.password);

  }
}

class UserLogInParams {
  final String email;
  final String password;

  UserLogInParams(
      { required this.email, required this.password});
}
