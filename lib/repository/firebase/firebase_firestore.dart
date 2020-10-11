import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery_test/app/ui/scene/home_page/bloc/load_mode.dart';
import 'package:gallery_test/entity/firebase_picture.dart';
import 'package:gallery_test/repository/firebase/firebase_storage.dart';

class FireStore {
  static const _LOADLIMIT = 10;
  DocumentSnapshot lastDocument;

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

  Future<QuerySnapshot> _continueLoading(String mode) async {
    return FirebaseFirestore.instance
        .collection("images")
        .where('type', isEqualTo: mode)
        .startAfterDocument(lastDocument)
        .limit(_LOADLIMIT)
        .get();
  }

  Future<QuerySnapshot> _loadFromStart(String mode) async {
    return await FirebaseFirestore.instance
        .collection("images")
        .where('type', isEqualTo: mode)
        .limit(_LOADLIMIT)
        .get();
  }

  Future<List<FirebasePicture>> getPictures<Mode extends LoadMode>(
      {bool reset = false}) async {
    if (reset) {
      lastDocument = null;
    }
    List<FirebasePicture> result = [];
    QuerySnapshot snapshots;
    if (lastDocument != null) {
      snapshots = await _continueLoading(Mode.toString());
    } else {
      snapshots = await _loadFromStart(Mode.toString());
    }
    List<QueryDocumentSnapshot> imagesData = snapshots.docs;
    imagesData.forEach((snapshot) {
      Map<String, dynamic> data = snapshot.data();
      if (data.isNotEmpty) {
        result.add(FirebasePicture.fromData(data));
      }
    });
    if (imagesData.isNotEmpty) {
      lastDocument = imagesData.last;
    }
    return result;
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
