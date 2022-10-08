import 'dart:io';

///this repository is responsive for picking an image from any source
abstract class ImagesRepository {
  Future<File?> pickAnImage();
}