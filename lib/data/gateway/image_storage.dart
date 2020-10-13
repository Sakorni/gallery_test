import 'dart:io';

abstract class ImageStorage {
  Future<dynamic> downloadPicture();
  Future<dynamic> uploadPicture(File file);
}
