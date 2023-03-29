import '../../../models/models.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState{}

class MovieDetailLoading extends MovieDetailState{}

class MovieDetailLoaded extends MovieDetailState{
  final MovieDetail movieDetail;
  final List<Movie> similarList;
  final List<Cast> casts;
  final List<Crew> crews;
  final List<Video> videos;

  MovieDetailLoaded({
    required this.movieDetail,
    required this.casts,
    required this.crews,
    required this.similarList,
    required this.videos,
  });

}

class MovieDetailError extends MovieDetailState{}