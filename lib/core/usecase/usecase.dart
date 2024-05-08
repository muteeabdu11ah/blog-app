import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/failure.dart';

abstract interface class usecase<SucessType,Params>{
  Future<Either<Failure,SucessType>> call(Params params);
  
}

abstract interface class usecase2<SucessType,Params>{
  Future<Either<Failure,void>> call(void vd);
  
}