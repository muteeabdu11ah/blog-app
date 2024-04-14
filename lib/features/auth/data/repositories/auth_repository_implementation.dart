import 'package:fpdart/src/either.dart';
import 'package:fyp/core/error/exceptions.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:fyp/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryiterface implements AuthRepository {
  final AuthRemoteDataource remoteDataSource;

  AuthRepositoryiterface(this.remoteDataSource);
  @override
  Future<Either<Failure, String>> logInwithEmailPassword(
      {required String email, required String password}) async {
    // TODO: implement logInwithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpwithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userID = await remoteDataSource.signUpWithEmailPassword(
        email: email,
        password: password,
        name: name,
      );

      return right(userID);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
