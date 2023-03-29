import '../apis/apis.dart';
import '../models/models.dart';

class CastAndCrewRepository{
  static final CastAndCrewRepository _singleton = CastAndCrewRepository._internal();
  final CreditAPI _creditAPI = CreditAPI();

  factory CastAndCrewRepository() => _singleton;
  CastAndCrewRepository._internal();

  Future<List<Cast>> getCastFromMovie({required int movieId}) =>
      _creditAPI.getCastFromMovies(idMovie: movieId);

  Future<List<Crew>> getCrewFromMovie({required int movieId}) =>
      _creditAPI.getCrewFromMovies(idMovie: movieId);

  Future<List<Cast>> getCastFromTVSeries({required int idTv}) =>
      _creditAPI.getCastFromTVSeries(idTvSeries: idTv);

  Future<List<Crew>> getCrewFromTVSeries({required int idTv}) =>
      _creditAPI.getCrewFromTVSeries(idTvSeries: idTv);

}