import 'dart:io';
import 'package:memories/domain/entity/memory.dart';

///this repository is responsive for saving and loading events
abstract class MemoriesRepository{
  void saveMemory(Memory memory, File imageFile);
  Future<List<Memory>> loadMemories();
}