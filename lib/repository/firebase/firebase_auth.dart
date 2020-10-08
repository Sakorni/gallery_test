import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery_test/data/entity/errors/errors.dart';

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
    return '';
  }

  static Future<String> signUp(
      {@required String email,
      @required String password,
      @required String name,
      String dayOfBirth}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FireStore.addUser(name: name, dayOfBirth: dayOfBirth, email: email);
      return signIn(email: email, password: password);
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
