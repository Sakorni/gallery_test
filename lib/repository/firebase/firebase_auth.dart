import 'package:firebase_auth/firebase_auth.dart';
import '../../data/entity/firebase_user.dart' as user;
import 'package:flutter/material.dart';
import 'package:gallery_test/app/utils/errors.dart';

import 'firebase_firestore.dart';

class FireAuth {
  static Future<user.FirebaseUser> signIn(
      {@required String email, @required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var user = await FireStore.getUser(userCredential.user.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw NoSuchUser();
      } else if (e.code == 'wrong-password') {
        throw WrongPassword();
      }
    }
    return null;
  }

  static Future<user.FirebaseUser> signUp(
      {@required String email,
      @required String oldPassword,
      @required String name,
      @required String confrimPassword,
      String dayOfBirth}) async {
    if (oldPassword != confrimPassword) throw PasswordNotConfirmed();
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: oldPassword);
      return FireStore.addUser(
          name: name,
          dayOfBirth: dayOfBirth ?? '',
          email: email,
          id: user.user.uid);
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
