part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class UpdateField extends SettingsEvent {
  Map<String, String> value = {};
  final String email;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  UpdateField(
      {@required String name,
      @required String dayOfBirth,
      @required this.email,
      @required this.oldPassword,
      @required this.newPassword,
      @required this.confirmPassword}) {
    value[AppUserStrings.name] = name;
    value[AppUserStrings.dayOfBirth] = dayOfBirth;
  }
}

class DeleteAccount extends SettingsEvent {}

class SignOut extends SettingsEvent {}
