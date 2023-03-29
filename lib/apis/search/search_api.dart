import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/models.dart';
import '../../values/values.dart';

class SearchAPI {
  final Dio _dio = Dio();

  Future<List<Movie>> searchMovies(
      {required String query, int page = 1}) async {
    var params = {
      "api_key": apiKey,
      "language": 'en-US',
      "page": page,
      "query": query
    };
    try {
      final response =
          await _dio.get("$baseURL/search/movie", queryParameters: params);
      var movies = response.data["results"] as List;
      List<Movie> searchMovieList =
          movies.map((movie) => Movie.fromJson(movie)).toList();
      return searchMovieList;
    } catch (error, stacktrace) {
      debugPrint('Load searchMovies Fail:  $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<List<TVSeries>> searchTVSeries({required String query, int page = 1}) async{
    var params = {
      "api_key": apiKey,
      "language": 'en-US',
      "page": page,
      "query": query
    };

    try{
      final response = await _dio.get("$baseURL/search/tv",queryParameters: params);
      var tvSeries = response.data["results"] as List;

      List<TVSeries> searchTVList = tvSeries.map((tv) => TVSeries.fromJson(tv)).toList();

      return searchTVList;

    }catch(error, stacktrace){
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }
}
