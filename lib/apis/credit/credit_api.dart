import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../models/models.dart';
import '../../values/values.dart';

class CreditAPI {
  final Dio _dio = Dio();

  Future<List<Cast>> getCastFromMovies({required int idMovie}) async {
    try {
      final response = await _dio.get('$baseURL/movie/$idMovie/credits',
          queryParameters: defaultParam);
      var casts = response.data['cast'] as List;
      List<Cast> castList = casts.map((cast) => Cast.fromJson(cast)).toList();

      return castList;
    } catch (error, stacktrace) {
      debugPrint('Load getCastFromMovies Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<List<Crew>> getCrewFromMovies({required int idMovie}) async {
    try {
      final response = await _dio.get('$baseURL/movie/$idMovie/credits',
          queryParameters: defaultParam);
      var crews = response.data['crew'] as List;
      List<Crew> crewList = crews.map((crew) => Crew.fromJson(crew)).toList();

      return crewList;
    } catch (error, stacktrace) {
      debugPrint('Load getCrewFromMovies Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<List<Cast>> getCastFromTVSeries({required int idTvSeries}) async {
    try {
      final response = await _dio.get('$baseURL/tv/$idTvSeries/credits',
          queryParameters: defaultParam);
      var casts = response.data['cast'] as List;
      List<Cast> castList = casts.map((cast) => Cast.fromJson(cast)).toList();

      return castList;
    } catch (error, stacktrace) {
      debugPrint('Load getCastFromTVSeries Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<List<Crew>> getCrewFromTVSeries({required int idTvSeries}) async {
    try {
      final response = await _dio.get('$baseURL/tv/$idTvSeries/credits',
          queryParameters: defaultParam);
      var crews = response.data['crew'] as List;
      List<Crew> crewList = crews.map((crew) => Crew.fromJson(crew)).toList();

      return crewList;
    } catch (error, stacktrace) {
      debugPrint('Load getCrewFromTVSeries Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }
}
