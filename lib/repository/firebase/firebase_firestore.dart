import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireStore {
  static Future<bool> addUser(
      {String name, DateTime dayOfBirth, String email}) async {
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
}
