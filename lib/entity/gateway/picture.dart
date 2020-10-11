abstract class Picture {
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

  Map<String, dynamic> toJson();

  void incViews();
}
