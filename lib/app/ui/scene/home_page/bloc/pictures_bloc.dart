import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery_test/app/ui/scene/home_page/bloc/load_mode.dart';
import 'package:gallery_test/entity/gateway/picture.dart';
import 'package:gallery_test/repository/firebase/firebase_firestore.dart';
import 'package:meta/meta.dart';

part 'pictures_event.dart';
part 'pictures_state.dart';

class PicturesBloc<Mode extends LoadMode>
    extends Bloc<PicturesEvent, PicturesState> {
  PicturesBloc() : super(FirstLoadingPictures()) {
    this.add(LoadMorePictures());
  }

  FireStore _firestore = FireStore();
  List<Picture> _pictures = [];

  @override
  Stream<PicturesState> mapEventToState(
    PicturesEvent event,
  ) async* {
    try {
      if (event is LoadMorePictures) {
        List<Picture> newPictures = await _firestore.getPictures<Mode>();
        _pictures.insertAll(_pictures.length, newPictures);
        yield PicturesScreenState(_pictures);
      }
      if (event is ResetPictures) {
        _pictures = await _firestore.getPictures<Mode>(reset: true);
        yield PicturesScreenState(_pictures);
      }
    } catch (e) {
      if (e is SocketException || e is TimeoutException || e is HttpException) {
        yield NoInternetConnection();
      }
    }
  }
}
