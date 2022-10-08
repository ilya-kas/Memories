part of 'map_bloc.dart';

@immutable
abstract class MapState {}

class Hidden extends MapState {}

class Loading extends MapState {}

abstract class LoadedState extends MapState {
  final List<Memory> memories;

  LoadedState(this.memories);
}

class NoTempMemory extends LoadedState {
  NoTempMemory(List<Memory> memories) : super(memories);
}

class HasATempMemory extends LoadedState {
  final Memory tempMemory;

  HasATempMemory(List<Memory> memories, this.tempMemory) : super(memories);
}

class WithInfoPanel extends LoadedState {
  final LoadedState coveredState;
  final int id; //which marker's image is showing

  WithInfoPanel(this.id, this.coveredState) : super(coveredState.memories);
}