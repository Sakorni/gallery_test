import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery_test/app/utils/errors.dart';

import 'firebase_firestore.dart';

class FireAuth {
  static Future<String> signIn(
      {@required String email, @required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw NoSuchUser();
      } else if (e.code == 'wrong-password') {
        throw WrongPassword();
      }
    }

    /// TODO ???
    /// лучше эксепшн на ошибки не от firebase
    /// ниже аналогично
    return '';
  }

  static Future<String> signUp(
      {@required String email,
      @required String oldPassword,
      @required String name,
      @required String confrimPassword,
      String dayOfBirth}) async {
    if (oldPassword != confrimPassword) throw PasswordNotConfirmed();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: oldPassword);
      FireStore.addUser(name: name, dayOfBirth: dayOfBirth ?? '', email: email);

      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPassword();
      } else if (e.code == 'email-already-in-use') {
        throw AlreadyRegistred();
      } else if (e.code == "invalid-email ") throw InvalidEmail();
    }
    return null;
  }
}
