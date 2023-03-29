import 'dart:async';

import 'package:application/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/models.dart';
import '../../blocs.dart';

class DiscoverMovieViewBloc
    extends Bloc<DiscoverMovieViewEvent, DiscoverMovieViewState> {
  final DiscoverBloc _discoverBloc;
  final RefreshController movieController;
  final DiscoverRepository _repository;
  late final StreamSubscription subscription;

  DiscoverMovieViewBloc(
      this._repository, this._discoverBloc, this.movieController)
      : super(DiscoverMovieViewInitial()) {
    subscription = _discoverBloc.stream.listen((discoverState) {
      debugPrint(" Movie Event " + state.toString());
      if (discoverState is InitDiscover && discoverState.index == 0) {
        if (discoverState.query.isEmpty) {
          add(MovieFetchingEvent());
        } else {
          add(MovieSearchEvent(query: discoverState.query));
        }
      }
    });
    on<MovieFetchingEvent>(_onLoadMovie);
    on<MovieSearchEvent>(_onSearchMovie);
    on<OnNextMovieEvent>(_onNextPageMovie);
  }

  Future<void> _onLoadMovie(
      MovieFetchingEvent event, Emitter<DiscoverMovieViewState> emit) async {
    var movieList = await _repository.getMovie();
    if (movieList.isNotEmpty) {
      emit(DiscoverMovieListLoaded(lists: movieList));
    } else {
      emit(DiscoverMovieListEmpty(text: 'Movie'));
    }
  }

  // on search in DiscoverMovieViewBloc -> return list or empty list
  Future<void> _onSearchMovie(
      MovieSearchEvent event, Emitter<DiscoverMovieViewState> emit) async {
    try {
      List<Movie> lists = await _repository.searchMovie(event.query);
      if (lists.isEmpty) {
        emit(DiscoverMovieListEmpty(text: 'Movie'));
      } else {
        emit(DiscoverMovieListLoaded(lists: lists));
      }
    } catch (e) {
      emit(DiscoverMovieLoadFailure());
    }
  }

  Future<void> _onNextPageMovie(
      OnNextMovieEvent event, Emitter<DiscoverMovieViewState> emit) async {
    try {
      var currentState = state;
      List<Movie> newLists;
      if (currentState is DiscoverMovieListLoaded) {
        int currentPage = currentState.currentPage;
        if (_discoverBloc.search.text.isEmpty) {
          // search
          newLists = await _repository.getMovie(page: currentPage + 1);

          // print('${newLists.first.title}');
        } else {
          newLists = await _repository.searchMovie(_discoverBloc.search.text,
              page: currentPage + 1);
        }

        if (newLists.isEmpty || currentPage == 500) {
          emit(currentState.update(currentPage: -1));
        } else {
          currentState.lists.addAll(newLists);
          emit(currentState.update(
              lists: currentState.lists, currentPage: currentPage + 1));
        }
        movieController.loadComplete();
      }
    } catch (e) {
      emit(DiscoverMovieLoadFailure());
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    subscription.cancel();
    movieController.dispose();

    return super.close();
  }
}
