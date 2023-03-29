abstract class DiscoverEvent {}

class OnSearch extends DiscoverEvent {
  final String query;

  OnSearch({required this.query});
}

class OnChangeTabDiscover extends DiscoverEvent {
  final int index;

  OnChangeTabDiscover({ required this.index});
}

class OnClear extends DiscoverEvent {}
