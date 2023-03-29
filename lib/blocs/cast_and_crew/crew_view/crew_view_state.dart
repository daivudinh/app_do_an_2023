import '../../../models/models.dart';

abstract class CrewViewState{}

class CrewViewInitial extends CrewViewState{}

class CrewViewLoaded extends CrewViewState{
  List<Crew> crews;

  CrewViewLoaded({required this.crews});
}

class CrewViewError extends CrewViewState{}

