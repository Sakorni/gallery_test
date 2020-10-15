import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gallery_test/data/entity/firebase_user.dart';
import 'package:meta/meta.dart';

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  RepositoryBloc(this._user) : super(RepositoryInitial());
  FirebaseUser _user;
  FirebaseUser get user => this._user;
  @override
  Stream<RepositoryState> mapEventToState(
    RepositoryEvent event,
  ) async* {}
}
