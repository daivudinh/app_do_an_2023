import 'package:application/blocs/blocs.dart';
import 'package:application/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

class HomeMovieBloc extends Bloc<HomeMovieEvent, HomeMovieState> {
  final HomeRepository _repository;

  HomeMovieBloc(this._repository) : super(HomeMovieInitial()) {
    on<MovieStartedEvent>(_onLoadMovie);
  }

  Future<void> _onLoadMovie(
      MovieStartedEvent event, Emitter<HomeMovieState> emit) async {
    emit(MovieLoading());
    try {
      var topRatedList = await _repository.getTopRateMovie();
      var popularList = await _repository.getPopularMovie();
      var nowPlayingList = await _repository.getNowPlayingMovie();
      var popularVideo = await _repository.getVideoFromMovie(
          movieId: popularList.first.id ?? 1);

      emit(MovieLoaded(
        topRatedList: topRatedList,
        popularList: popularList,
        nowPlayingList: nowPlayingList,
        popularVideo: popularVideo.first,
      ));
    } catch (_) {
      emit(MovieError());
    }
  }
}
