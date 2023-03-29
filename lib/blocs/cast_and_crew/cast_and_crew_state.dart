abstract class CastAndCrewState{}

class CastAndCrewInitial extends CastAndCrewState{
  final int index;
  CastAndCrewInitial({required this.index});

  CastAndCrewInitial update({int? index}){
    return CastAndCrewInitial(index: index ?? this.index);
  }
}