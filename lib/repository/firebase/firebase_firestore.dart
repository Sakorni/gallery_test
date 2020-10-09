import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireStore {
  /// TODO ???
  /// абстрактный класс с реализацией, почему?
  /// статика не есть хорошо для таких дел
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
}
