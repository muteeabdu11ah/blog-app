part of 'ml_bloc.dart';

@immutable
sealed class MlEvent {}

class Mlpredict extends MlEvent{
  final File imagefile;

  Mlpredict(this.imagefile);
}
