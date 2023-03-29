import '../../../models/models.dart';

abstract class DiscoverTVSeriesViewState {}

class DiscoverTVSeriesViewInitial extends DiscoverTVSeriesViewState {}

class DiscoverTVSeriesListLoaded extends DiscoverTVSeriesViewState {
  final List<TVSeries> lists;
  final int currentPage;

  DiscoverTVSeriesListLoaded({required this.lists, this.currentPage = 1});

  DiscoverTVSeriesListLoaded update({List<TVSeries>? lists, int? currentPage}) {
    return DiscoverTVSeriesListLoaded(
        lists: lists ?? this.lists,
        currentPage: currentPage ?? this.currentPage);
  }
}

class DiscoverTVSeriesListEmpty extends DiscoverTVSeriesViewState {
  final String text;

  DiscoverTVSeriesListEmpty({required this.text});
}

class DiscoverTVSeriesLoadFailure extends DiscoverTVSeriesViewState{}
