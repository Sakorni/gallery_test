import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_test/entity/firebase_picture.dart';
import 'package:gallery_test/entity/gateway/image_storage.dart';

class FireBaseStorage implements ImageStorage {
  Future downloadPicture() {}

  Future<FirebasePicture> uploadPicture(File file) async {
    RegExp regex = RegExp(r'image_picker(.*\.\w+)');
    RegExpMatch m = regex.firstMatch(file.path);
    String name = m.group(1);
    StorageReference ref = FirebaseStorage.instance.ref().child('images/$name');
    StorageUploadTask task = ref.putFile(file);
    StorageTaskSnapshot snapshot = await task.onComplete;
    String url = await snapshot.ref.getDownloadURL();
    return FirebasePicture(name: name, url: url);
    //TODO: TryCatch
  }
}