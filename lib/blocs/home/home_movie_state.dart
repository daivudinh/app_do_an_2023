import '../../models/models.dart';

abstract class HomeMovieState {}

class HomeMovieInitial extends HomeMovieState {}

class MovieLoading extends HomeMovieState {}

class MovieLoaded extends HomeMovieState {
  final List<Movie> topRatedList;
  final List<Movie> popularList;
  final List<Movie> nowPlayingList;
  final Video popularVideo;

  MovieLoaded({
    required this.topRatedList,
    required this.popularList,
    required this.popularVideo,
    required this.nowPlayingList,
  });

}

class MovieError extends HomeMovieState {}
