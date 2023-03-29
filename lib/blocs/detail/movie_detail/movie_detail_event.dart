abstract class MovieDetailEvent{}

class MovieDetailStartedEvent extends MovieDetailEvent{
  final int idMovie;

  MovieDetailStartedEvent({required this.idMovie});
}