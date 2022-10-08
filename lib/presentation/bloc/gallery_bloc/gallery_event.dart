part of 'gallery_bloc.dart';

@immutable
abstract class GalleryEvent {}

class LoadGalleryEvent extends GalleryEvent {}

class SelectImageEvent extends GalleryEvent {
  final int num;

  SelectImageEvent(this.num);
}