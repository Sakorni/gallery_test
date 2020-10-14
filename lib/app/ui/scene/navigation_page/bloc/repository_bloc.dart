import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gallery_test/data/gateway/user.dart';
import 'package:meta/meta.dart';

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  RepositoryBloc(this._user) : super(RepositoryInitial());
  User _user;
  User get user => this._user;
  @override
  Stream<RepositoryState> mapEventToState(
    RepositoryEvent event,
  ) async* {}
}
