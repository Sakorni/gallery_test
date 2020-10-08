import 'package:gallery_test/app/resources/app_strings.dart';

abstract class AuthException implements Exception {
  String message;
}

class NoSuchUser implements AuthException {
  @override
  String message = AppStrings.noSuchUser;
}

class AlreadyRegistred implements AuthException {
  @override
  String message = AppStrings.alreadyRegistred;
}

class WrongPassword implements AuthException {
  @override
  String message = AppStrings.wrongPassword;
}

class WeakPassword implements AuthException {
  @override
  String message = AppStrings.weakPassword;
}
