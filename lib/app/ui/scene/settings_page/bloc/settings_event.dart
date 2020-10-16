part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class UpdateDataField extends SettingsEvent {
  final String field;
  final String value;

  UpdateDataField.nameField(this.value) : field = AppUserStrings.name;
  UpdateDataField.dayOfBirthField(this.value)
      : field = AppUserStrings.dayOfBirth;
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
