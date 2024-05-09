import 'package:bloc/bloc.dart';
import 'package:fyp/features/auth/domain/usecases/current_user.dart';
import 'package:meta/meta.dart';

import '../../domain/usecase/get_username_by_uid.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
    final GetUserNameByUid _nameByUid;

  UserBloc({    required GetUserNameByUid nameByUid,
})  : _nameByUid = nameByUid,
super(UserInitial()) {
    on<UserEvent>((event, emit) {
    });
    on<UserGetUsername>(_fetchName);

  }

  void _fetchName(UserGetUsername event, Emitter<UserState> emit) async {
    final res = await _nameByUid(NoParams());
    res.fold((l) => emit(UserFailure(error: l.message)),
        (r) => emit(UserNameFetchSucess(r)));
  }
}
