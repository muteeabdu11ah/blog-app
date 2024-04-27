// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/features/auth/domain/entities/user.dart';

import 'package:fyp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp usersignup,
  })  : _userSignUp = usersignup,
        super(AuthInitial()) {
    on<AuthSignup>((event, emit) async {
      final res = await _userSignUp(UserSignUpParams(
          name: event.name, email: event.email, password: event.password));

      res.fold(
        (l) => emit(AuthFailure(l.message)), 
        (r) => emit(AuthSucess(r)));
    });
  }
}
