import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:memories/data/source/memories_storage.dart';
import 'package:memories/domain/entity/memory.dart';
import 'package:memories/util/injection_container.dart';

void main(){
  MemoriesStorage storage= MemoriesStorageImpl(sl());

  group('MemoriesStorage functionality', () {
    test(
        'saving to firebase database',
        () async {
          //given
          List<Memory> start = await storage.loadMemories();
          //Memory memory = Memory(position, image); //todo
          //File image = File(path);  //todo
          int num = start.length;
          //when
          //await storage.saveMemory(memory, image, num);
          //then
          List<Memory> result = await storage.loadMemories();
          expect(num+1, result.length);
        }
    );
  });
}
