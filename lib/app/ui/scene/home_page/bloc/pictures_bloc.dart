import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:gallery_test/app/ui/scene/home_page/bloc/load_mode.dart';
import 'package:gallery_test/data/gateway/picture.dart';
import 'package:gallery_test/repository/firebase/firebase_firestore.dart';
import 'package:meta/meta.dart';

part 'pictures_event.dart';
part 'pictures_state.dart';

class PicturesBloc<Mode extends LoadMode>
    extends Bloc<PicturesEvent, PicturesState> {
  PicturesBloc({this.email}) : super(FirstLoadingPictures()) {
    this.add(LoadMorePictures());
  }
  final String email;

  FireStore _firestore = FireStore();
  List<Picture> _pictures = [];

  @override
  Stream<PicturesState> mapEventToState(
    PicturesEvent event,
  ) async* {
    try {
      if (Mode == UserMode) {
        if (event is LoadMorePictures) {
          List<Picture> newPictures = await _firestore.getUsersPictures(email);
          _pictures.insertAll(_pictures.length, newPictures);
          yield PicturesScreenState(_pictures);
        }
        if (event is ResetPictures) {
          _pictures = await _firestore.getUsersPictures(email, reset: true);
          yield PicturesScreenState(_pictures);
        }
      } else {
        if (event is LoadMorePictures) {
          List<Picture> newPictures = await _firestore.getPictures<Mode>();
          _pictures.insertAll(_pictures.length, newPictures);
          yield PicturesScreenState(_pictures);
        }
        if (event is ResetPictures) {
          _pictures = await _firestore.getPictures<Mode>(reset: true);
          yield PicturesScreenState(_pictures);
        }
      }
    } catch (e) {
      if (e is SocketException || e is TimeoutException || e is HttpException) {
        yield NoInternetConnection();
      }
    }
  }
}
