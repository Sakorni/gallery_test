import 'package:firebase_auth/firebase_auth.dart';
import '../../data/entity/firebase_user.dart' as fbUser;
import 'package:flutter/material.dart';
import 'package:gallery_test/app/utils/errors.dart';

import 'firebase_firestore.dart';

class FireAuth {
  static Future<fbUser.FirebaseUser> signIn(
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

  static Future<fbUser.FirebaseUser> signUp(
      {@required String email,
      @required String oldPassword,
      @required String name,
      @required String confrimPassword,
      String dayOfBirth}) async {
    if (oldPassword != confrimPassword) throw PasswordNotConfirmed();
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: oldPassword);
      fbUser.FirebaseUser firebaseUser = fbUser.FirebaseUser.defaultUser(
          name: name, dayOfBirth: dayOfBirth, email: email, id: user.user.uid);
      return FireStore.addUser(user: firebaseUser);
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
