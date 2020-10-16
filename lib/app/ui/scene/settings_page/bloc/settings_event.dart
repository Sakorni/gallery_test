part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class UpdateDataField extends SettingsEvent {
  Map<String, String> value;

  UpdateDataField(String name, String dayOfBirth) {
    value[AppUserStrings.name] = name;
    value[AppUserStrings.dayOfBirth] = dayOfBirth;
  }
}

class UpdateEmail extends SettingsEvent {
  final String email;

  UpdateEmail(this.email);
}

class UpdatePassword extends SettingsEvent {
  final String oldPassword;
  final String newPassword;

  UpdatePassword(this.oldPassword, this.newPassword);
}

class DeleteAccount extends SettingsEvent {}

class SignOut extends SettingsEvent {}
