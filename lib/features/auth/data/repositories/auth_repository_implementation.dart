import 'package:fpdart/src/either.dart';
import 'package:fyp/core/error/exceptions.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:fyp/features/auth/domain/entities/user.dart';
import 'package:fyp/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryiterface implements AuthRepository {
  final AuthRemoteDataource remoteDataSource;

  AuthRepositoryiterface(this.remoteDataSource);
  @override
  Future<Either<Failure, UserData>> logInwithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signInWithEmailPassword(
          email: email, password: password);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on AuthException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserData>> signUpwithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(
        email: email,
        password: password,
        name: name,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on AuthException catch (e) {
      return left(Failure(e.message));
    }
  }
}
