import 'dart:async';

import 'package:application/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/models.dart';
import '../../blocs.dart';

class DiscoverTVSeriesViewBloc
    extends Bloc<DiscoverTVSeriesViewEvent, DiscoverTVSeriesViewState> {
  final DiscoverBloc _discoverBloc;
  final RefreshController tvSeriesController;
  final DiscoverRepository _repository;
  late final StreamSubscription subscription;

  DiscoverTVSeriesViewBloc(
      this._repository, this._discoverBloc, this.tvSeriesController)
      : super(DiscoverTVSeriesViewInitial()) {
    subscription = _discoverBloc.stream.listen((discoverState) {
      if (discoverState is InitDiscover && discoverState.index == 1) {
        if (discoverState.query.isEmpty) {
          add(TVSeriesFetchingEvent());
        } else {
          add(TVSeriesSearchEvent(query: discoverState.query));
        }
      }
    });
    on<TVSeriesFetchingEvent>(_onLoadTVSeries);
    on<TVSeriesSearchEvent>(_onSearchTVSeries);
    on<OnNextTVSeriesEvent>(_onNextPageTVSeries);
  }

  Future<void> _onLoadTVSeries(TVSeriesFetchingEvent event,
      Emitter<DiscoverTVSeriesViewState> emit) async {
    var movieList = await _repository.getTVSeries();
    if (movieList.isNotEmpty) {
      emit(DiscoverTVSeriesListLoaded(lists: movieList));
    } else {
      emit(DiscoverTVSeriesListEmpty(text: 'Movie'));
    }
  }

  // on search in DiscoverTVSeriesViewBloc -> return list or empty list
  Future<void> _onSearchTVSeries(TVSeriesSearchEvent event,
      Emitter<DiscoverTVSeriesViewState> emit) async {
    try {
      List<TVSeries> lists = await _repository.searchTVSeries(event.query);
      if (lists.isEmpty) {
        emit(DiscoverTVSeriesListEmpty(text: 'TV Series'));
      } else {
        emit(DiscoverTVSeriesListLoaded(lists: lists));
      }
    } catch (e) {
      emit(DiscoverTVSeriesLoadFailure());
    }
  }

  Future<void> _onNextPageTVSeries(OnNextTVSeriesEvent event,
      Emitter<DiscoverTVSeriesViewState> emit) async {
    try {
      var currentState = state;
      List<TVSeries> newLists;
      if (currentState is DiscoverTVSeriesListLoaded) {
        int currentPage = currentState.currentPage;
        if (_discoverBloc.search.text.isEmpty) {
          // search
          newLists = await _repository.getTVSeries(page: currentPage + 1);

          // print('${newLists.first.title}');
        } else {
          newLists = await _repository.searchTVSeries(_discoverBloc.search.text,
              page: currentPage + 1);
        }

        if (newLists.isEmpty || currentPage == 500) {
          emit(currentState.update(currentPage: -1));
        } else {
          currentState.lists.addAll(newLists);
          emit(currentState.update(
              lists: currentState.lists, currentPage: currentPage + 1));
        }
        tvSeriesController.loadComplete();
      }
    } catch (e) {
      emit(DiscoverTVSeriesLoadFailure());
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    subscription.cancel();
    tvSeriesController.dispose();

    return super.close();
  }
}
