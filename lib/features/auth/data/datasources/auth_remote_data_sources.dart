import 'package:fyp/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataource {
  Future<String> signUpWithEmailPassword(
      {required String name, required String email, required String password});
  Future<String> signInWithEmailPassword(
      {required String email, required String password});
}

class AuthRemoteDataourceImplementation implements AuthRemoteDataource {
  final SupabaseClient supabaseclient;

  AuthRemoteDataourceImplementation(this.supabaseclient);
  @override
  Future<String> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final signInresponse = supabaseclient.auth.signInWithPassword(
        email: email,
        password: password,
      );
    //S if(signInresponse. == null)
    } catch (e) {}
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseclient.auth
          .signUp(email: email, password: password, data: {'name': name});
      if (response.user == null) throw ServerException('user is null');

      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
