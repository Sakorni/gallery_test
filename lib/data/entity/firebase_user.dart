import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/data/gateway/user.dart';

class FirebaseUser implements User {
  String _name;
  String get name => this._name;
  String _email;
  String get email => this._email;
  String _dayOfBirth;
  String get dayOfBirth => this._dayOfBirth;

  FirebaseUser(
      {@required String name,
      @required String email,
      @required String dayOfBirth}) {
    this._name = name;
    this._email = email;
    this._dayOfBirth = dayOfBirth;
  }

  FirebaseUser.fromData(Map<String, dynamic> data) {
    this._name = data[AppUserStrings.name];
    this._email = data[AppUserStrings.email];
    this._dayOfBirth = data[AppUserStrings.dayOfBirth];
  }
  Map<String, dynamic> toJson() {
    return {
      AppUserStrings.name: name,
      AppUserStrings.email: email,
      AppUserStrings.dayOfBirth: dayOfBirth,
    };
  }
}
