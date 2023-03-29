import '../apis/apis.dart';
import '../models/models.dart';

class HomeRepository{
  static final HomeRepository _singleton = HomeRepository._internal();
  final MovieAPI _movieAPI = MovieAPI();

  factory HomeRepository() => _singleton;
  HomeRepository._internal();

  Future<List<Movie>> getTopRateMovie({int page = 1}) =>
      _movieAPI.getTopRateMovie(page: page);

  Future<List<Movie>> getPopularMovie({int page = 1}) =>
      _movieAPI.getPopularMovies(page: page);

  Future<List<Movie>> getNowPlayingMovie({int page = 1}) =>
      _movieAPI.getNowPlayingMovies(page: page);

  Future<List<Video>> getVideoFromMovie({required int movieId}) =>
      _movieAPI.getVideoFromMovie(movieId: movieId);
}