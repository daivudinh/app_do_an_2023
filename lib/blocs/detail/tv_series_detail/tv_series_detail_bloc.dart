import 'package:application/blocs/blocs.dart';
import 'package:application/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

class TVSeriesDetailBloc
    extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  final DetailRepository _repository;

  TVSeriesDetailBloc(this._repository) : super(TVSeriesDetailInitial()) {
    on<TVSeriesDetailStartedEvent>(_onLoadingTVSeriesDetail);
  }

  Future<void> _onLoadingTVSeriesDetail(TVSeriesDetailStartedEvent event,
      Emitter<TVSeriesDetailState> emit) async {
    emit(TVSeriesDetailLoading());
    try {
      var tvDetail = await _repository.getTVDetail(tvId: event.idTv);
      var similarList = await _repository.getSimilarTVSeries(tvId: event.idTv);
      var castList = await _repository.getCastFromTVSeries(idTv: event.idTv);
      var crewList = await _repository.getCrewFromTVSeries(idTv: event.idTv);
      var videoList = await _repository.getVideoFromTV(tvId: event.idTv);

      emit(TVSeriesDetailLoaded(
          tvSeriesDetail: tvDetail,
          similarList: similarList,
          crews: crewList,
          casts: castList,
          videos: videoList));
    } catch (_) {
      emit(TVSeriesDetailError());
    }
  }
}
