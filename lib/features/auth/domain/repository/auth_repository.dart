import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/failure.dart';

abstract interface class AuthRepository{
 Future<Either<Failure,String>> signUpwithEmailPassword(
    {
      required String name,
      required String email,
      required String password
    }
  );

   Future<Either<Failure,String>> logInwithEmailPassword(
    {
      required String email,
      required String password
    }
  );
}