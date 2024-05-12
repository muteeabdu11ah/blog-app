import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fyp/features/DiseasePrediction/data/model/ml_model.dart';
import 'package:fyp/features/DiseasePrediction/domain/usecase/Ml_predict_usecase.dart';
import 'package:meta/meta.dart';

part 'ml_event.dart';
part 'ml_state.dart';

class MlBloc extends Bloc<MlEvent, MlState> {
  final GetPrediction _getPrediction;
  MlBloc({required GetPrediction getPrediction})
      : _getPrediction = getPrediction,
        super(MlInitial()) {
    on<MlEvent>((_, emit) {
      emit(Mlloading());
    });
    on<Mlpredict>(_predictfunction);
  }

  void _predictfunction(Mlpredict event, Emitter<MlState> emit) async {
    emit(Mlloading());
    final res = await _getPrediction(FileParams(imageFile: event.imagefile));
    res.fold((l) {
      print(l);
      emit(Mlfailure(l.message));
    }, (r) {        
      print(r);

      emit(
        Mlsucess(model: r));
    });
  }
}
