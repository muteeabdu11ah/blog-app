import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ml_event.dart';
part 'ml_state.dart';

class MlBloc extends Bloc<MlEvent, MlState> {
  MlBloc() : super(MlInitial()) {
    on<MlEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
