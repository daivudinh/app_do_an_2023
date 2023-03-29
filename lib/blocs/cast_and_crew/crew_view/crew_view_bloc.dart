import 'package:application/blocs/blocs.dart';
import 'package:application/models/models.dart';
import 'package:application/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

class CrewViewBloc extends Bloc<CrewViewEvent, CrewViewState> {
  final CastAndCrewRepository _repository;
  CrewViewBloc(this._repository) : super(CrewViewInitial()) {
    on<LoadCrewInMovieEvent>(_loadingCrewInMovie);
    on<LoadCrewInTVSeriesEvent>(_loadingCrewInTVSeries);
  }

  Future<void> _loadingCrewInMovie(
      LoadCrewInMovieEvent event, Emitter<CrewViewState> emit) async {
    try {
      List<Crew> crews =
          await _repository.getCrewFromMovie(movieId: event.idMovie);
      emit(CrewViewLoaded(crews: crews));
    } catch (_) {
      emit(CrewViewError());
    }
  }

  Future<void> _loadingCrewInTVSeries(
      LoadCrewInTVSeriesEvent event, Emitter<CrewViewState> emit) async {
    try {
      List<Crew> crews =
          await _repository.getCrewFromTVSeries(idTv: event.idTv);
      emit(CrewViewLoaded(crews: crews));
    } catch (_) {
      emit(CrewViewError());
    }
  }
}
