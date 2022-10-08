import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:memories/domain/entity/memory.dart';
import 'package:memories/domain/use_case/get_stored_memories_usecase.dart';
import 'package:memories/domain/entity/bundle.dart';
import 'package:meta/meta.dart';

part 'gallery_event.dart';

part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GetStoredMemoriesUseCase _getStoredMemoriesUseCase;
  final Bundle args;

  GalleryBloc(this._getStoredMemoriesUseCase, this.args) : super(Hidden());

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    switch (event.runtimeType) {
      case LoadGalleryEvent:
        yield* _loadGallery(event as LoadGalleryEvent);
        break;
      case SelectImageEvent:
        yield* _selectImage(event as SelectImageEvent);
        break;
    }
  }

  Stream<GalleryState> _loadGallery(LoadGalleryEvent event) async* {
    yield Loading();
    List<Memory> memories = await _getStoredMemoriesUseCase();
    yield Loaded(memories);
  }

  Stream<GalleryState> _selectImage(SelectImageEvent event) async* {
    yield SwitchState(event.num);
  }
}
