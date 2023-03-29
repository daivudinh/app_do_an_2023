abstract class DiscoverState {}

class InitDiscover extends DiscoverState {
  final int index;
  final String query;

  InitDiscover({required this.index, this.query = ''});

  InitDiscover update({int? index, String? query}) {
    return InitDiscover(index: index ?? this.index, query: query ?? this.query);
  }
}
