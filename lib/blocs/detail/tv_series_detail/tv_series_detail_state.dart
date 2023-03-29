import '../../../models/models.dart';

abstract class TVSeriesDetailState {}

class TVSeriesDetailInitial extends TVSeriesDetailState{}

class TVSeriesDetailLoading extends TVSeriesDetailState{}

class TVSeriesDetailLoaded extends TVSeriesDetailState{
  final TVSeriesDetail tvSeriesDetail;
  final List<TVSeries> similarList;
  final List<Cast> casts;
  final List<Crew> crews;
  final List<Video> videos;

  TVSeriesDetailLoaded({
    required this.tvSeriesDetail,
    required this.casts,
    required this.crews,
    required this.similarList,
    required this.videos,
  });

}

class TVSeriesDetailError extends TVSeriesDetailState{}