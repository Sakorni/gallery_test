import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/utils/errors.dart';
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
  ) async* {
    try {
      if (event is UpdateField) {
        if (event.newPassword != event.confirmPassword)
          yield SettingsError(AppStrings.notConfirmed);
        else {
          yield SettingsProccess();
          await user.updateFields(event.value);
          if (event.oldPassword.isNotEmpty && event.newPassword.isNotEmpty) {
            await user.changePassword(event.oldPassword, event.newPassword);
          }
          if (event.email != user.email) {
            await user.updateEmail(event.email);
          }
          yield SettingsInitial();
        }
      }
      if (event is DeleteAccount) {
        yield SettingsProccess();
        await user.deleteUser();
        yield SettingsPopToWelcomeScreen();
      }
      if (event is SignOut) {
        yield SettingsPopToWelcomeScreen();
      }
    } on AuthException catch (e) {
      yield SettingsError(e.message);
    } on SocketException {
      yield SettingsError(AppStrings.onSocketException);
    }
  }
}
