import 'dart:io';

import 'package:memories/domain/entity/memory.dart';
import 'package:memories/domain/repository/memories_repository.dart';

///add memory to remote storage
class AddMemoryUseCase {
  final MemoriesRepository _memoriesRepository;

  AddMemoryUseCase(this._memoriesRepository);

  Future<void> call(Memory memory, File imageFile) async {
    _memoriesRepository.saveMemory(memory, imageFile);
  }
}