import 'dart:async';
import 'dart:io';

import 'package:gallery_test/app/ui/scene/home_page/bloc/pictures_bloc.dart';
import 'package:gallery_test/data/gateway/picture.dart';
import 'package:gallery_test/repository/firebase/firebase_firestore.dart';

class ProfilePicBloc extends PicturesBloc {
  final String email;
  FireStore _firestore = FireStore();
  List<Picture> _pictures = [];

  ProfilePicBloc(this.email);
  @override
  Stream<PicturesState> mapEventToState(
    PicturesEvent event,
  ) async* {
    if (event is LoadMorePictures) {
      try {
        if (event is LoadMorePictures) {
          List<Picture> newPictures = await _firestore.getUsersPictures(email);
          _pictures.insertAll(_pictures.length, newPictures);
          yield PicturesScreenState(_pictures);
        }
        if (event is ResetPictures) {
          _pictures = await _firestore.getUsersPictures(email, reset: true);
          yield PicturesScreenState(_pictures);
        }
      } catch (e) {
        if (e is SocketException ||
            e is TimeoutException ||
            e is HttpException) {
          yield NoInternetConnection();
        }
      }
    }
  }
}
