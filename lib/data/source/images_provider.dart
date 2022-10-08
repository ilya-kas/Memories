import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImagesProvider{
  Future<File?> pickAnImage();
}

class ImagesProviderImpl extends ImagesProvider {
  final ImagePicker picker = ImagePicker();

  @override
  Future<File?> pickAnImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    return File(image!.path);
  }

}