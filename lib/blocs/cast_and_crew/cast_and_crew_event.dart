abstract class CastAndCrewEvent{}

class OnChangeTab extends CastAndCrewEvent {
  final int index;
  OnChangeTab(this.index);
}
