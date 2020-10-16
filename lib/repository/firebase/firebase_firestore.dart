import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/scene/home_page/bloc/load_mode.dart';
import 'package:gallery_test/data/entity/firebase_picture.dart';
import 'package:gallery_test/data/entity/firebase_user.dart';
import 'package:gallery_test/repository/firebase/firebase_storage.dart';

class FireStore {
  static final _instance = FirebaseFirestore.instance;
  static const _LOADLIMIT = 10;
  DocumentSnapshot lastDocument;

  static Future<FirebaseUser> addUser({FirebaseUser user}) async {
    DocumentReference users = FirebaseFirestore.instance
        .collection(AppCollectionsStrings.users)
        .doc(user.id);
    await users.set(user.toJson());
    return user;
  }

  static Future<FirebaseUser> getUser(String id, String password) async {
    DocumentReference doc =
        _instance.collection(AppCollectionsStrings.users).doc(id);
    DocumentSnapshot snapshot = await doc.get();
    Map<String, dynamic> data = snapshot.data();
    return FirebaseUser.fromData(data, password);
  }

  static Future<void> deleteUser(
    String id,
  ) async {
    DocumentReference doc =
        _instance.collection(AppCollectionsStrings.users).doc(id);
    await doc.delete();
  }

  static Future<void> updateAuthor(String newAuthor, String oldAuthor) async {
    QuerySnapshot pictures = await _instance
        .collection(AppCollectionsStrings.images)
        .where(AppPictureStrings.pictureAuthor, isEqualTo: oldAuthor)
        .get();
    pictures.docChanges.forEach((element) {
      element.doc.reference
          .update({AppPictureStrings.pictureAuthor: newAuthor});
    });
  }

  static Future updatefield(
      {String collection,
      String docId,
      Map<String, dynamic> updateValue}) async {
    DocumentReference doc = _instance.collection(collection).doc(docId);
    await doc.update(updateValue);
  }

  Future<QuerySnapshot> _continueLoading({String field, String equalTo}) async {
    return _instance
        .collection(AppCollectionsStrings.images)
        .where(field, isEqualTo: equalTo)
        .startAfterDocument(lastDocument)
        .limit(_LOADLIMIT)
        .get();
  }

  Future<QuerySnapshot> _loadFromStart({String field, String equalTo}) async {
    return _instance
        .collection(AppCollectionsStrings.images)
        .where(field, isEqualTo: equalTo)
        .limit(_LOADLIMIT)
        .get();
  }

  Future<List<FirebasePicture>> getPictures<Mode extends LoadMode>({
    bool reset = false,
  }) async {
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
      snapshots = await _continueLoading(
          field: AppPictureStrings.pictureType, equalTo: mode);
    } else {
      snapshots = await _loadFromStart(
          field: AppPictureStrings.pictureType, equalTo: mode);
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

  Future<List<FirebasePicture>> getUsersPictures(String email,
      {bool reset = false}) async {
    if (reset) {
      lastDocument = null;
    }
    List<FirebasePicture> result = [];
    QuerySnapshot snapshots;
    if (lastDocument != null) {
      snapshots = await _continueLoading(
          field: AppPictureStrings.pictureAuthor, equalTo: email);
    } else {
      snapshots = await _loadFromStart(
          field: AppPictureStrings.pictureAuthor, equalTo: email);
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

  static Future<bool> createImg(File file,
      {String name,
      String description,
      List<String> tags,
      String author}) async {
    try {
      String url = await FireBaseStorage().uploadPicture(file);
      FirebasePicture pic = FirebasePicture(
          author: author,
          description: description,
          tags: tags,
          name: name,
          url: url);
      CollectionReference images =
          _instance.collection(AppCollectionsStrings.images);
      await images.add(pic.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
