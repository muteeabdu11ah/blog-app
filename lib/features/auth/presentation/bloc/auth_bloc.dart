// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fyp/core/common/entities/user.dart';
import 'package:fyp/features/auth/domain/usecases/current_user.dart';
import 'package:fyp/features/auth/domain/usecases/user_log_in.dart';

import 'package:fyp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userLogIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required AppUserCubit appUserCubit,
    required CurrentUser currentuser,
    required UserSignIn userlogin,
    required UserSignUp usersignup,
  })  : _appUserCubit = appUserCubit,
        _userSignUp = usersignup,
        _userLogIn = userlogin,
        _currentUser = currentuser,
        super(AuthInitial()) {
          on<AuthEvent>((_, emit) => emit(AuthLoading()),);
    on<AuthSignup>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogIn);
    on<AuthIsUserLoggedIn>(_AuthIsUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignup event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(UserSignUpParams(
        name: event.name, email: event.email, password: event.password));

    res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitAuthSucess(r, emit));
  }

  void _onAuthLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    final res = await _userLogIn(
        UserLogInParams(email: event.email, password: event.password));

    res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitAuthSucess(r, emit));
  }

  void _AuthIsUserLoggedIn(
    
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
            emit(AuthLoading());

    final res = await _currentUser(NoParams());
    res.fold((l) {
      print('email');

      emit(AuthFailure(l.message));
    }, (r) {
      _emitAuthSucess(r, emit);
    });
  }

  void _emitAuthSucess(UserData user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSucess(user));
  }
}
