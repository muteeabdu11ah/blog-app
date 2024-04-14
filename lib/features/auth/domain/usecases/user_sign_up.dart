import 'package:fpdart/src/either.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/core/usecase/usecase.dart';
import 'package:fyp/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements usecase<String, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
   return await authRepository.signUpwithEmailPassword(
        name: params.name, email: params.email, password: params.password);

  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams(
      {required this.name, required this.email, required this.password});
}
