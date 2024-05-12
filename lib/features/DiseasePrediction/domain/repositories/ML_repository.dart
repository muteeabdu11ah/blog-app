import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/features/DiseasePrediction/data/model/ml_model.dart';

abstract interface class MLRepository{
  Future<Either<Failure,MlModel>> predictDisease(File imageFile);
}
