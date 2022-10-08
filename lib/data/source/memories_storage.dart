import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memories/data/model/memory_model.dart';
import 'package:memories/domain/entity/memory.dart';
import 'package:memories/util/exception/no_connection_exception.dart';
import 'package:memories/util/network_checker.dart';

abstract class MemoriesStorage {
  Future<void> saveMemory(Memory memory, File imageFile, int num);

  Future<List<Memory>> loadMemories();
}

class MemoriesStorageImpl extends MemoriesStorage {
  late final FirebaseStorage _storage;
  late final FirebaseDatabase _database;
  final NetworkChecker _checker;

  MemoriesStorageImpl(this._checker) {
    init();
  }

  void init() async {
    await Firebase.initializeApp();
    _storage = FirebaseStorage.instance;
    _database = FirebaseDatabase.instance;
  }

  @override
  Future<List<Memory>> loadMemories() async {
    if (!await _checker.isConnected) throw NoConnectionException();

    List<Memory> memories = [];
    final imagesLink = _database.reference().child('images');
    await imagesLink.once().then((DataSnapshot snapshot) {
      List<dynamic> images = snapshot.value;
      images.forEach((value) {
        final coordinates =
            LatLng(value["coordinates"][0], value["coordinates"][1]);
        final imageFromLink = NetworkImage(value["image_link"]);
        memories.add(Memory(coordinates, imageFromLink));
      });
    });

    return memories;
  }

  @override
  Future<void> saveMemory(Memory memory, File imageFile, int num) async {
    if (!await _checker.isConnected) throw NoConnectionException();

    final fileName = memory.position.toJson().toString(); //this value to make names unique
    final firebaseStorageRef = _storage.ref().child('images/$fileName');
    final taskSnapshot = await firebaseStorageRef.putFile(imageFile);
    taskSnapshot.ref.getDownloadURL().then(
          (value) => _addEvent(
            MemoryModel(memory.position, FileImage(imageFile), value, num),
          ),
        );
  }

  /// add info about a new memory to database
  void _addEvent(MemoryModel memory) {
    final imagesLink = _database.reference().child('images');
    imagesLink
        .child("${memory.num}")
        .child("coordinates")
        .set(memory.position.toJson());
    imagesLink
        .child("${memory.num}")
        .child("image_link")
        .set(memory.link);
  }
}
