import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../models/models.dart';
import '../../values/values.dart';

class TVSeriesAPI {
  final Dio _dio = Dio();

  Future<List<TVSeries>> getPopularTV({int page = 1}) async {
    try {
      final response =
          await _dio.get("$baseURL/tv/popular", queryParameters: paramWithPage(page: page));
      var tvSeries = response.data["results"] as List;
      List<TVSeries> tvList =
          tvSeries.map((tv) => TVSeries.fromJson(tv)).toList();

      return tvList;
    } catch (error, stacktrace) {
      debugPrint('Load getPopularTV Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<TVSeriesDetail> getTVDetail({required int tvId}) async{
    try{
      final response = await _dio.get("$baseURL/tv/$tvId",queryParameters: defaultParam);
      TVSeriesDetail detail = TVSeriesDetail.fromJson(response.data);

      return detail;

    }catch(error, stacktrace){
      debugPrint('Load getTVDetail Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<List<Video>> getVideoFromTV({required int tvId}) async{
    try{
      final response = await _dio.get("$baseURL/tv/$tvId/videos",queryParameters: defaultParam);
      var videos =  response.data["results"] as List;
      List<Video> listVideo = videos.map((video) => Video.fromJson(video)).toList();
      return listVideo;

    }catch(error, stacktrace){
      debugPrint('Load getVideoFromTV Fail: $error');
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }

  Future<List<TVSeries>> getSimilarTVShow({required int tvId ,int page = 1}) async{
    try{
      final response = await _dio.get("$baseURL/tv/$tvId/similar",queryParameters: paramWithPage(page: page),);
      var tvShows = response.data["results"] as List;
      List<TVSeries> tvShowList = tvShows.map((tvShow) => TVSeries.fromJson(tvShow)).toList();
      return tvShowList;

    }catch(error, stacktrace){
      throw Exception("Exception: $error, stacktrace: $stacktrace");
    }
  }


}
