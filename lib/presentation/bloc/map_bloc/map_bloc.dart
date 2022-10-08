import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memories/domain/entity/bundle.dart';
import 'package:memories/domain/entity/memory.dart';
import 'package:memories/domain/use_case/add_memory_usecase.dart';
import 'package:memories/domain/use_case/get_stored_memories_usecase.dart';
import 'package:memories/domain/use_case/pick_an_image_usecase.dart';
import 'package:memories/util/exception/no_image_picked_exception.dart';
import 'package:memories/util/exception/wrong_state_exception.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final AddMemoryUseCase _addMemoryUseCase;
  final GetStoredMemoriesUseCase _getStoredMemoriesUseCase;
  final PickAnImageUseCase _pickAnImageUseCase;
  final Bundle args;

  MapBloc(this._addMemoryUseCase,
      this._getStoredMemoriesUseCase,
      this._pickAnImageUseCase,
      this.args) : super(Hidden());

  @override
  Stream<MapState> mapEventToState(MapEvent event) async*{
    switch (event.runtimeType){
      case LoadMapEvent:
        yield* _loadMap(event as LoadMapEvent);
        break;
      case AddMarkerEvent:
        yield* _addMarker(event as AddMarkerEvent);
        break;
      case SaveMarkerEvent:
        yield* _saveMarker(event as SaveMarkerEvent);
        break;
      case ShowMarkerDescriptionEvent:
        yield* _showMarkerDescription(event as ShowMarkerDescriptionEvent);
        break;
      case HideMarkerDescriptionEvent:
        yield* _hideMarkerDescription(event as HideMarkerDescriptionEvent);
        break;
    }
  }

  Stream<MapState> _loadMap(LoadMapEvent event) async*{
    yield Loading();
    List<Memory> memories = await _getStoredMemoriesUseCase();
    yield NoTempMemory(memories);
  }

  Stream<MapState> _addMarker(AddMarkerEvent event) async*{
    List<Memory> memories = await _getStoredMemoriesUseCase();
    yield HasATempMemory(memories, Memory.noImage(event.coordinates));
  }

  Stream<MapState> _saveMarker(SaveMarkerEvent event) async*{
    if (!((state is HasATempMemory) ||
          ((state is WithInfoPanel) && !((state as WithInfoPanel).coveredState is HasATempMemory))
         ))
      throw WrongStateException();
    HasATempMemory lastState = state as HasATempMemory;

    File? image = await _pickAnImageUseCase();
    if (image == null)
      throw NoImagePickedException();
    lastState.tempMemory.image = FileImage(image);
    _addMemoryUseCase(lastState.tempMemory, image);

    var memories = lastState.memories;
    memories.add(lastState.tempMemory);
    yield NoTempMemory(memories);
  }

  Stream<MapState> _showMarkerDescription(ShowMarkerDescriptionEvent event) async*{
    if (!(state is LoadedState))
      throw WrongStateException();
    if (state is WithInfoPanel)
      yield WithInfoPanel(event.id, (state as WithInfoPanel).coveredState);
    else
      yield WithInfoPanel(event.id, state as LoadedState);
  }

  Stream<MapState> _hideMarkerDescription(HideMarkerDescriptionEvent event) async*{
    if (!(state is WithInfoPanel))
      throw WrongStateException();
    yield (state as WithInfoPanel).coveredState;
  }
}
