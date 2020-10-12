import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/entity/gateway/picture.dart';
import 'package:gallery_test/repository/firebase/firebase_firestore.dart';

class FirebasePicture implements Picture {
  String _docId;
  String get docId => this._docId;
  String _name;
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
    this._author = data['author'];
    this._countOfViews = data['count_of_views'];
    this._createdAt = DateTime.fromMillisecondsSinceEpoch(
        (data['createdAt'] as Timestamp).millisecondsSinceEpoch);
    this._name = data['name'];
    this._docId = data['id'];
    this._tags = List.from(data['tags']);
    this._type = data['type'];
    this._url = data['url'];
  }

  FirebasePicture({String name, String url}) {
    this._name = name;
    this._url = url;
    this._type = "New";
    this._author = "ssakorni@gmail.com"; // TODO: Complete
    this._countOfViews = 0;
    this._createdAt = DateTime.now();
    this._tags = [];
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'count_of_views': countOfViews,
      'createdAt': createdAt,
      'name': name,
      'tags': tags,
      'type': type,
      'author': author
    };
  }

  void incViews() {
    Map<String, dynamic> values = {"count_of_views": countOfViews};
    this._countOfViews++;
    if (countOfViews == 15) {
      values["type"] = AppStrings.photoModePopular;
    }
    FireStore.updatefield(
        collection: AppStrings.collectionImages,
        docId: docId,
        updateValue: values);
  }
}
