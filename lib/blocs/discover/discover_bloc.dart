import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../blocs.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final TextEditingController search;

  DiscoverBloc({required this.search}) : super(InitDiscover(index: 0)) {
    on<OnSearch>(onSearch);
    on<OnChangeTabDiscover>(_onChangeTabDiscover);
    on<OnClear>(_onClear);
  }

  // onSearch in Discover Bloc -> update query search
  Future<void> onSearch(OnSearch event, Emitter<DiscoverState> emit) async {
    var currentState = state;
    if (currentState is InitDiscover) {
      emit(currentState.update(query: event.query));
    }
  }

  Future<void> _onChangeTabDiscover(
      OnChangeTabDiscover event, Emitter<DiscoverState> emit) async {
    var currentState = state;
    if (currentState is InitDiscover) {
      emit(currentState.update(index: event.index));
    }
  }

  Future<void> _onClear(OnClear event, Emitter<DiscoverState> emit) async {
    var currentState = state;
    search.clear();
    if (currentState is InitDiscover) {
      emit(currentState.update(query: ''));
    }
  }

  @override
  Future<void> close() {
    search.dispose();
    return super.close();
  }

}
