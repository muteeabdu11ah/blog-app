import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/core/usecase/usecase.dart';
import 'package:fyp/core/common/entities/user.dart';
import 'package:fyp/features/auth/domain/repository/auth_repository.dart';

class UserLogOut implements usecase2<UserData, void>{
  final AuthRepository authRepository;

  UserLogOut(this.authRepository);

  @override
  Future<Either<Failure, void>> call(void params) async {
return await authRepository.logOut();
  }

}

