import '../apis/apis.dart';
import '../models/models.dart';

class DetailRepository {
  static final DetailRepository _singleton = DetailRepository._internal();
  final CreditAPI _creditAPI = CreditAPI();
  final MovieAPI _movieAPI = MovieAPI();
  final TVSeriesAPI _tvSeriesAPI = TVSeriesAPI();

  factory DetailRepository() => _singleton;

  DetailRepository._internal();

  /// Movie Detail
  Future<MovieDetail> getMovieDetail({required int idMovie}) =>
      _movieAPI.getMovieDetail(movieId: idMovie);

  Future<List<Cast>> getCastFromMovie({required int idMovie}) =>
      _creditAPI.getCastFromMovies(idMovie: idMovie);

  Future<List<Crew>> getCrewFromMovie({required int idMovie}) =>
      _creditAPI.getCrewFromMovies(idMovie: idMovie);

  Future<List<Movie>> getSimilarMovie({required int idMovie}) =>
      _movieAPI.getSimilarMovies(movieId: idMovie);

  Future<List<Video>> getVideoFromMovie({required int idMovie}) =>
      _movieAPI.getVideoFromMovie(movieId: idMovie);


  /// Tv Series Detail
  Future<TVSeriesDetail> getTVDetail({required int tvId}) =>
      _tvSeriesAPI.getTVDetail(tvId: tvId);

  Future<List<Cast>> getCastFromTVSeries({required int idTv}) =>
      _creditAPI.getCastFromTVSeries(idTvSeries: idTv);

  Future<List<Crew>> getCrewFromTVSeries({required int idTv}) =>
      _creditAPI.getCrewFromTVSeries(idTvSeries: idTv);

  Future<List<TVSeries>> getSimilarTVSeries({required int tvId}) =>
      _tvSeriesAPI.getSimilarTVShow(tvId: tvId);

  Future<List<Video>> getVideoFromTV({required int tvId}) =>
      _tvSeriesAPI.getVideoFromTV(tvId: tvId);
}
