import 'package:application/blocs/blocs.dart';
import 'package:application/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

import '../../../models/cast.dart';

class CastViewBloc extends Bloc<CastViewEvent, CastViewState> {
  final CastAndCrewRepository _repository;
  CastViewBloc(this._repository) : super(CastViewInitial()) {
    on<LoadCastInMovieEvent>(_loadingCastInMovie);
    on<LoadCastInTVSeriesEvent>(_loadingCastInTVSeries);
  }

  Future<void> _loadingCastInMovie(
      LoadCastInMovieEvent event, Emitter<CastViewState> emit) async {
    try {
      List<Cast> casts =
          await _repository.getCastFromMovie(movieId: event.idMovie);
      emit(CastViewLoaded(casts: casts));
    } catch (_) {
      emit(CastViewError());
    }
  }

  Future<void> _loadingCastInTVSeries(
      LoadCastInTVSeriesEvent event, Emitter<CastViewState> emit) async {
    try {
      List<Cast> casts =
          await _repository.getCastFromTVSeries(idTv: event.idTv);
      emit(CastViewLoaded(casts: casts));
    } catch (_) {
      emit(CastViewError());
    }
  }
}
