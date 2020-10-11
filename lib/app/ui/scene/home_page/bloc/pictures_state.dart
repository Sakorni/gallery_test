part of 'pictures_bloc.dart';

@immutable
abstract class PicturesState {}

class FirstLoadingPictures extends PicturesState {}

class PicturesScreenState extends PicturesState {
  final List<Picture> pictures;

  PicturesScreenState(this.pictures);
}

class NoInternetConnection extends PicturesState {}
