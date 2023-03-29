abstract class DiscoverTVSeriesViewEvent{}

class TVSeriesFetchingEvent extends DiscoverTVSeriesViewEvent {}

class TVSeriesSearchEvent extends DiscoverTVSeriesViewEvent {
  final String query;

  TVSeriesSearchEvent({required this.query});
}

class OnNextTVSeriesEvent extends DiscoverTVSeriesViewEvent {}

