import 'dart:io';

import 'package:memories/domain/repository/images_repository.dart';

///pick new image
class PickAnImageUseCase {
  final ImagesRepository _imagesRepository;

  PickAnImageUseCase(this._imagesRepository);

  Future<File?> call() async {
    return await _imagesRepository.pickAnImage();
  }
}