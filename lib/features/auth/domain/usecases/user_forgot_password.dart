import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/core/usecase/usecase.dart';
import 'package:fyp/core/common/entities/user.dart';
import 'package:fyp/features/auth/domain/repository/auth_repository.dart';

class UserForgotPassword implements usecase3<UserData, UserForgotPasswordParams>{
  final AuthRepository authRepository;

  UserForgotPassword(this.authRepository);

  @override
  Future<Either<Failure, void>> call(UserForgotPasswordParams params) async {
return await authRepository.resetPasswordForEmail(email: params.email);
  }

}

class UserForgotPasswordParams {
  final String email;

  UserForgotPasswordParams(
      { required this.email});
}


