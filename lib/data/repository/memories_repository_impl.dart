import 'dart:io';
import 'package:memories/data/source/memories_storage.dart';
import 'package:memories/domain/entity/memory.dart';
import 'package:memories/domain/repository/memories_repository.dart';
import 'package:memories/util/exception/no_connection_exception.dart';

class MemoriesRepositoryImpl implements MemoriesRepository{
  final MemoriesStorage _storage;
  List<Memory>? _memories; //if null then data is needed to be fetched from firebase storage

  MemoriesRepositoryImpl(this._storage);

  @override
  Future<List<Memory>> loadMemories() async {
    if (_memories != null)
      return Future.value(_memories!);

    try{
      _memories = await _storage.loadMemories();
    } on NoConnectionException {
      //log
      return Future.value([]);
    }
    return _memories!;
  }

  @override
  Future<void> saveMemory(Memory memory, File imageFile) async {
    try{
      _storage.saveMemory(memory, imageFile, _memories!.length-1);
    } on NoConnectionException {
      //log
    }
  }
}