part of 'ml_bloc.dart';

@immutable
sealed class MlState {}

final class MlInitial extends MlState {}

final class Mlloading extends MlState {}

final class Mlsucess extends MlState{
  final MlModel model;

  Mlsucess({required this.model});
}

final class Mlfailure extends MlState{
  final  String message;

  Mlfailure( this.message);
  
}

