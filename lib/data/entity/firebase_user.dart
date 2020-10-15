import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/data/gateway/user.dart';
import 'package:gallery_test/repository/firebase/firebase_firestore.dart';

class FirebaseUser implements User {
  String _id;
  String get id => this._id;
  String _name;
  String get name => this._name;
  String _email;
  String get email => this._email;
  String _dayOfBirth;
  String get dayOfBirth => this._dayOfBirth;
  int _views;
  int get views => this._views;
  int _loaded;
  int get loaded => this._loaded;

  FirebaseUser.defaultUser(
      {@required String name,
      @required String email,
      @required String dayOfBirth,
      @required String id}) {
    this._name = name;
    this._id = id;
    this._views = 0;
    this._loaded = 0;
    this._email = email;
    this._dayOfBirth = dayOfBirth;
  }

  FirebaseUser.fromData(Map<String, dynamic> data) {
    this._name = data[AppUserStrings.name];
    this._email = data[AppUserStrings.email];
    this._views = data[AppUserStrings.views];
    this._loaded = data[AppUserStrings.loaded];
    this._id = data[AppUserStrings.id];
    this._dayOfBirth = data[AppUserStrings.dayOfBirth];
  }
  Map<String, dynamic> toJson() {
    return {
      AppUserStrings.name: name,
      AppUserStrings.id: id,
      AppUserStrings.loaded: loaded,
      AppUserStrings.views: views,
      AppUserStrings.email: email,
      AppUserStrings.dayOfBirth: dayOfBirth,
    };
  }

  void incViews() {
    this._views++;
    FireStore.updatefield(
        collection: AppCollectionsStrings.users,
        docId: id,
        updateValue: {AppUserStrings.views: views});
  }

  void incLoaded() {
    this._loaded++;
    FireStore.updatefield(
        collection: AppCollectionsStrings.users,
        docId: id,
        updateValue: {AppUserStrings.loaded: loaded});
  }
}
