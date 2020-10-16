import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/data/entity/firebase_user.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final FirebaseUser user;
  SettingsBloc(this.user) : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {}
}
