abstract class DiscoverMovieViewEvent{}

class MovieFetchingEvent extends DiscoverMovieViewEvent {}

class MovieSearchEvent extends DiscoverMovieViewEvent {
  final String query;

  MovieSearchEvent({required this.query});
}

class OnNextMovieEvent extends DiscoverMovieViewEvent {}

