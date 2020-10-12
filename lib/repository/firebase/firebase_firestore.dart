import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/scene/home_page/bloc/load_mode.dart';
import 'package:gallery_test/entity/firebase_picture.dart';
import 'package:gallery_test/repository/firebase/firebase_storage.dart';

class FireStore {
  static final _instance = FirebaseFirestore.instance;
  static const _LOADLIMIT = 10;
  DocumentSnapshot lastDocument;

  static Future<bool> addUser(
      {String name, String dayOfBirth, String email}) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection(AppCollectionsStrings.users);
      await users.add(
        {"Name": name, "Email": email, "DayOfBirth": dayOfBirth},
      );
      return true;
    } on FirebaseException {
      return false;
    }
  }

  static Future updatefield(
      {String collection,
      String docId,
      Map<String, dynamic> updateValue}) async {
    DocumentReference doc = _instance.collection(collection).doc(docId);
    await doc.update(updateValue);
  }

  Future<QuerySnapshot> _continueLoading(String mode) async {
    return _instance
        .collection(AppCollectionsStrings.images)
        .where(AppPictureStrings.pictureType, isEqualTo: mode)
        .startAfterDocument(lastDocument)
        .limit(_LOADLIMIT)
        .get();
  }

  Future<QuerySnapshot> _loadFromStart(String mode) async {
    return _instance
        .collection(AppCollectionsStrings.images)
        .where(AppPictureStrings.pictureType, isEqualTo: mode)
        .limit(_LOADLIMIT)
        .get();
  }

  Future<List<FirebasePicture>> getPictures<Mode extends LoadMode>(
      {bool reset = false}) async {
    String mode;
    if (Mode == NewLoadMode) {
      mode = AppPictureStrings.pictureModeNew;
    } else if (Mode == PopularLoadMode) {
      mode = AppPictureStrings.pictureModePopular;
    }
    if (reset) {
      lastDocument = null;
    }
    List<FirebasePicture> result = [];
    QuerySnapshot snapshots;
    if (lastDocument != null) {
      snapshots = await _continueLoading(mode);
    } else {
      snapshots = await _loadFromStart(mode);
    }
    List<QueryDocumentSnapshot> imagesData = snapshots.docs;
    imagesData.forEach((snapshot) {
      Map<String, dynamic> data = snapshot.data();
      if (data.isNotEmpty) {
        data['id'] = snapshot.id;
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
