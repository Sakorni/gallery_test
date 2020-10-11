part of 'pictures_bloc.dart';

@immutable
abstract class PicturesEvent {}

class LoadMorePictures extends PicturesEvent {}

class ResetPictures extends PicturesEvent {}
