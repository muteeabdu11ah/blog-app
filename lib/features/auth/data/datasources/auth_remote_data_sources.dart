import 'package:fyp/core/error/exceptions.dart';
import 'package:fyp/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataource {
  Session? get curretUserSession;
  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String email, required String password});
  Future<UserModel> signInWithEmailPassword(
      {required String email, required String password});

  Future<UserModel?> getCurrentUserData();

  Future<void> logOutUsser();
}

class AuthRemoteDataourceImplementation implements AuthRemoteDataource {
  final SupabaseClient supabaseclient;
  AuthRemoteDataourceImplementation(this.supabaseclient);

  @override
  // TODO: implement curretUserSession
  Session? get curretUserSession => supabaseclient.auth.currentSession;

  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final signInresponse = await supabaseclient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (signInresponse.user == null) {
        throw ServerException('user is null');
      }
      return UserModel.fromJson(signInresponse.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseclient.auth
          .signUp(email: email, password: password, data: {'name': name});
      if (response.user == null) throw ServerException('user is null');

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (curretUserSession != null) {
        final userData = await supabaseclient
            .from('profiles')
            .select()
            .eq('id', curretUserSession!.user.id);
        return UserModel.fromJson(userData.first).copyWith(
          email: curretUserSession!.user.email,
          
        );
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<void> logOutUsser()async {
    try {
    await  supabaseclient.auth.signOut();
    } catch (e) {
            throw ServerException(e.toString());

    }
  }
}
