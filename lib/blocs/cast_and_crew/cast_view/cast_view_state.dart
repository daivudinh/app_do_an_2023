import '../../../models/models.dart';

abstract class CastViewState{}

class CastViewInitial extends CastViewState{}

class CastViewLoaded extends CastViewState{
  List<Cast> casts;

  CastViewLoaded({required this.casts});
}

class CastViewError extends CastViewState{}

