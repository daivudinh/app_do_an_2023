import 'package:application/blocs/blocs.dart';
import 'package:bloc/bloc.dart';

class CastAndCrewBloc extends Bloc<CastAndCrewEvent, CastAndCrewState> {
  CastAndCrewBloc() : super(CastAndCrewInitial(index: 0)) {
    on<OnChangeTab>((event, emit) {
      var currentState = state;
      if (currentState is CastAndCrewInitial) {
        emit(currentState.update(index: event.index));
      }
    });
  }
}
