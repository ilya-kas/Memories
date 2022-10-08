part of 'gallery_bloc.dart';

@immutable
abstract class GalleryState {}

class Hidden extends GalleryState {}

class Loading extends GalleryState {}

class Loaded extends GalleryState {
  final List<Memory> memories;

  Loaded(this.memories);
}

class SwitchState extends GalleryState {
  final int id;

  SwitchState(this.id); //id of selected memory
}