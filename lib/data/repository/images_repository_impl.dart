import 'dart:io';

import 'package:memories/data/source/images_provider.dart';
import 'package:memories/domain/repository/images_repository.dart';

class ImagesRepositoryImpl implements ImagesRepository{
  final ImagesProvider _provider;

  ImagesRepositoryImpl(this._provider);

  @override
  Future<File?> pickAnImage() {
    return _provider.pickAnImage();
  }

}
