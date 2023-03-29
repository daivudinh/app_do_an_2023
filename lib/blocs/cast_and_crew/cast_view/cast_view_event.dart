abstract class CastViewEvent {}

class LoadCastInMovieEvent extends CastViewEvent{
  final int idMovie;
  LoadCastInMovieEvent({required this.idMovie});
}

class LoadCastInTVSeriesEvent extends CastViewEvent{
  final int idTv;
  LoadCastInTVSeriesEvent({required this.idTv});
}