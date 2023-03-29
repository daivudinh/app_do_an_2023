

import '../apis/apis.dart';
import '../models/models.dart';

class DiscoverRepository {
  static final DiscoverRepository _singleton = DiscoverRepository._internal();
  final MovieAPI _movieAPI = MovieAPI();
  final TVSeriesAPI _tvSeriesAPI = TVSeriesAPI();
  final SearchAPI _searchAPI = SearchAPI();

  factory DiscoverRepository() => _singleton;
  DiscoverRepository._internal();

  Future<List<Movie>> getMovie({int page = 1}) =>
      _movieAPI.getPopularMovies(page: page);

  Future<List<TVSeries>> getTVSeries({int page = 1}) =>
      _tvSeriesAPI.getPopularTV(page: page);

  Future<List<Movie>> searchMovie(String query, {int page = 1}) =>
      _searchAPI.searchMovies(query: query, page: page);

  Future<List<TVSeries>> searchTVSeries(String query, {int page = 1}) =>
      _searchAPI.searchTVSeries(query: query, page: page);
}
