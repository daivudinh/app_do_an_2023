abstract class TVSeriesDetailEvent{}

class TVSeriesDetailStartedEvent extends TVSeriesDetailEvent{
  final int idTv;

  TVSeriesDetailStartedEvent({required this.idTv});
}