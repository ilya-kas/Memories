part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class LoadMapEvent extends MapEvent {}

class AddMarkerEvent extends MapEvent {
  final LatLng coordinates;

  AddMarkerEvent(this.coordinates);
}

class SaveMarkerEvent extends MapEvent {}

class ShowMarkerDescriptionEvent extends MapEvent {
  final int id;

  ShowMarkerDescriptionEvent(this.id);
}

class HideMarkerDescriptionEvent extends MapEvent {}