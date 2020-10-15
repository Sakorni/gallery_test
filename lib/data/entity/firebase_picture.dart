import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/data/gateway/picture.dart';
import 'package:gallery_test/repository/firebase/firebase_firestore.dart';

class FirebasePicture implements Picture {
  String _docId;
  String get docId => this._docId;
  String _name;
  String _description;
  String get description => this._description;
  String get name => this._name;
  String _url;
  String get url => this._url;
  int _countOfViews;
  int get countOfViews => this._countOfViews;
  List<String> _tags;
  List<String> get tags => this._tags;
  String _type;
  String get type => this._type;
  DateTime _createdAt;
  DateTime get createdAt => this._createdAt;
  String _author;
  String get author => this._author;

  FirebasePicture.fromData(Map<String, dynamic> data) {
    this._author = data[AppPictureStrings.pictureAuthor];
    this._countOfViews = data[AppPictureStrings.pictureViews];
    this._createdAt = DateTime.fromMillisecondsSinceEpoch(
        (data[AppPictureStrings.pictureCreated] as Timestamp)
            .millisecondsSinceEpoch);
    this._name = data[AppPictureStrings.pictureName];
    this._docId = data['id'];
    this._tags = List.from(data[AppPictureStrings.pictureTags]);
    this._type = data[AppPictureStrings.pictureType];
    this._url = data[AppPictureStrings.pictureUrl];
    this._description = data[AppPictureStrings.pictureDescription];
  }

  FirebasePicture(
      {String name,
      String url,
      String description,
      List<String> tags,
      String author}) {
    this._name = name;
    this._url = url;
    this._type = AppPictureStrings.pictureModeNew;
    this._author = author;
    this._countOfViews = 0;
    this._description = description;
    this._createdAt = DateTime.now();
    this._tags = tags;
  }

  Map<String, dynamic> toJson() {
    return {
      AppPictureStrings.pictureUrl: url,
      AppPictureStrings.pictureViews: countOfViews,
      AppPictureStrings.pictureCreated: createdAt,
      AppPictureStrings.pictureName: name,
      AppPictureStrings.pictureTags: tags,
      AppPictureStrings.pictureType: type,
      AppPictureStrings.pictureAuthor: author,
      AppPictureStrings.pictureDescription: description,
    };
  }

  void incViews() {
    Map<String, dynamic> values = {
      AppPictureStrings.pictureViews: countOfViews
    };
    this._countOfViews++;
    if (countOfViews == 10) {
      values[AppPictureStrings.pictureType] =
          AppPictureStrings.pictureModePopular;
    }
    FireStore.updatefield(
        collection: AppCollectionsStrings.images,
        docId: docId,
        updateValue: values);
  }
}
