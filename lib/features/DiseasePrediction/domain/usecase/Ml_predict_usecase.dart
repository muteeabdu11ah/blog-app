import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/core/usecase/usecase.dart';
import 'package:fyp/features/DiseasePrediction/data/model/ml_model.dart';
import 'package:fyp/features/DiseasePrediction/domain/repositories/ML_repository.dart';

class GetPrediction implements usecase<MlModel,FileParams>{

  final MLRepository mlRepository;

  GetPrediction(this.mlRepository);

  @override
  Future<Either<Failure, MlModel>> call(FileParams params) async {
    return await mlRepository.predictDisease(params.imageFile);
  
  
  }

}
class FileParams{
  final File imageFile;

  FileParams({required this.imageFile});
}