import 'package:bloc/bloc.dart';
import 'package:fyp/core/common/entities/user.dart';
import 'package:meta/meta.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(UserData? user){
    if (user == null){
      emit(AppUserInitial());
    }else{
      emit(AppUserLoggedIn(user));
    }
  }
}
