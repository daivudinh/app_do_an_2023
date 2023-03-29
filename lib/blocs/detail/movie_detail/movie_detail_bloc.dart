import 'package:application/blocs/blocs.dart';
import 'package:application/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final DetailRepository _repository;

  MovieDetailBloc(this._repository) : super(MovieDetailInitial()) {
    on<MovieDetailStartedEvent>(_onLoadingMovieDetail);
  }

  Future<void> _onLoadingMovieDetail(
      MovieDetailStartedEvent event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());
    try {
      var movieDetail =
          await _repository.getMovieDetail(idMovie: event.idMovie);
      var similarList =
          await _repository.getSimilarMovie(idMovie: event.idMovie);
      var castList = await _repository.getCastFromMovie(idMovie: event.idMovie);
      var crewList = await _repository.getCrewFromMovie(idMovie: event.idMovie);
      var videoList =
          await _repository.getVideoFromMovie(idMovie: event.idMovie);

      emit(MovieDetailLoaded(
          movieDetail: movieDetail,
          similarList: similarList,
          crews: crewList,
          casts: castList,
          videos: videoList));
    } catch (_) {
      emit(MovieDetailError());
    }
  }
}
