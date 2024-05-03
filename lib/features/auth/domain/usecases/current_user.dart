import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/core/usecase/usecase.dart';
import 'package:fyp/core/common/entities/user.dart';
import 'package:fyp/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements usecase<UserData, NoParams>{
  final AuthRepository authRepository;

  CurrentUser( this.authRepository);
  @override
  Future<Either<Failure, UserData>> call(NoParams params) async {
return await authRepository.currentUser();
  }

}

class NoParams{}