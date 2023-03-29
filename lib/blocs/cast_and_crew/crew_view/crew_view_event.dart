abstract class CrewViewEvent {}

class LoadCrewInMovieEvent extends CrewViewEvent{
  final int idMovie;
  LoadCrewInMovieEvent({required this.idMovie});
}

class LoadCrewInTVSeriesEvent extends CrewViewEvent{
  final int idTv;
  LoadCrewInTVSeriesEvent({required this.idTv});
}