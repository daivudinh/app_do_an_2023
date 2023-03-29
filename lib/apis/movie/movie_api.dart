import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../values/values.dart';
import '../../models/models.dart';

class MovieAPI {
  final Dio _dio = Dio();

  Future<List<Movie>> getTopRateMovie({int page = 1}) async {
    try {
      final response = await _dio.get(
        "$baseURL/movie/top_rated",
        queryParameters: paramWithPage(page: page),
      );
      var movies = response.data["results"] as List;
      List<Movie> movieList =
          movies.map((movie) => Movie.fromJson(movie)).toList();
      return movieList;
    } catch (error, stacktrace) {
      debugPrint('Load getTopRateMovie Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        "$baseURL/movie/now_playing",
        queryParameters: paramWithPage(page: page),
      );
      var movies = response.data["results"] as List;
      List<Movie> movieList =
          movies.map((movie) => Movie.fromJson(movie)).toList();
      return movieList;
    } catch (error, stacktrace) {
      debugPrint('Load getNowPlayingMovies Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        "$baseURL/movie/popular",
        queryParameters: paramWithPage(page: page),
      );
      var movies = response.data["results"] as List;
      List<Movie> movieList =
          movies.map((movie) => Movie.fromJson(movie)).toList();
      return movieList;
    } catch (error, stacktrace) {
      debugPrint('Load getPopularMovies Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<List<Movie>> getSimilarMovies(
      {required int movieId, int page = 1}) async {
    try {
      final response = await _dio.get(
        "$baseURL/movie/$movieId/similar",
        queryParameters: paramWithPage(page: page),
      );
      var movies = response.data["results"] as List;
      List<Movie> movieList =
          movies.map((movie) => Movie.fromJson(movie)).toList();
      return movieList;
    } catch (error, stacktrace) {
      debugPrint('Load getSimilarMovies Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<MovieDetail> getMovieDetail({required int movieId}) async {
    try {
      final response = await _dio.get(
        "$baseURL/movie/$movieId",
        queryParameters: defaultParam,
      );
      MovieDetail detail = MovieDetail.fromJson(response.data);

      return detail;
    } catch (error, stacktrace) {
      debugPrint('Load getMovieDetail Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<List<Video>> getVideoFromMovie({required int movieId}) async {
    try {
      final response = await _dio.get(
        "$baseURL/movie/$movieId/videos",
        queryParameters: defaultParam,
      );
      var videos = response.data["results"] as List;
      List<Video> listVideo =
          videos.map((video) => Video.fromJson(video)).toList();
      return listVideo;
    } catch (error, stacktrace) {
      debugPrint('Load getVideoFromMovie Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }
}
