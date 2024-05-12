import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/exceptions.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/features/DiseasePrediction/data/datasource/ml_datasource.dart';
import 'package:fyp/features/DiseasePrediction/data/model/ml_model.dart';
import 'package:fyp/features/DiseasePrediction/domain/repositories/ML_repository.dart';

class MlRepositoryImpl implements MLRepository {
  final MlRemoteDataSource mlRemoteDataSource;

  MlRepositoryImpl(this.mlRemoteDataSource);
  @override
  Future<Either<Failure, MlModel>> predictDisease(File imageFile) async {
    try {
      final res = await mlRemoteDataSource.mlModelPredict(imageFile);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
