import '../../../models/models.dart';

abstract class DiscoverMovieViewState {}

class DiscoverMovieViewInitial extends DiscoverMovieViewState {}

class DiscoverMovieListLoaded extends DiscoverMovieViewState {
  final List<Movie> lists;
  final int currentPage;

  DiscoverMovieListLoaded({required this.lists, this.currentPage = 1});

  DiscoverMovieListLoaded update({List<Movie>? lists, int? currentPage}) {
    return DiscoverMovieListLoaded(
        lists: lists ?? this.lists,
        currentPage: currentPage ?? this.currentPage);
  }
}

class DiscoverMovieListEmpty extends DiscoverMovieViewState {
  final String text;

  DiscoverMovieListEmpty({required this.text});
}

class DiscoverMovieLoadFailure extends DiscoverMovieViewState{}
