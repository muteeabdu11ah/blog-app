import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/core/common/entities/user.dart';

abstract interface class AuthRepository{
 Future<Either<Failure,UserData>> signUpwithEmailPassword(
    {
      required String name,
      required String email,
      required String password
    }
  );

   Future<Either<Failure,UserData>> logInwithEmailPassword(
    {
      required String email,
      required String password
    }
  );

  Future<Either<Failure,UserData>> currentUser();

  
}