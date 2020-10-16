part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {
  final String message;

  SettingsInitial({this.message});
}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}

class SettingsPopToWelcomeScreen extends SettingsState {}
