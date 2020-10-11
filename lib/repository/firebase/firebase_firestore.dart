import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_test/entity/firebase_picture.dart';
import 'package:gallery_test/repository/firebase/firebase_storage.dart';

class FireStore {
  static Future<bool> addUser(
      {String name, String dayOfBirth, String email}) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.add(
        {"Name": name, "Email": email, "DayOfBirth": dayOfBirth},
      );
      return true;
    } on FirebaseException {
      return false;
    }
  }

  static Future createImg(File file) async {
    FirebasePicture pic = await FireBaseStorage().uploadPicture(file);
    CollectionReference images =
        FirebaseFirestore.instance.collection("images");
    DocumentReference res = await images.add(pic.toJson());
    print(res.toString());
    //TODO: TryCatch
  }
}
