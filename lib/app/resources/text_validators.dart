import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/resources/app_strings.dart';

class TextValidators {
  static String emailValidatior(String value) {
    if (!value.contains('@')) {
      return AppStrings.emailNotValid;
    }
    return null;
  }

  static String passwordValidator(String value) {
    final RegExp passRegex = RegExp(r'[a-z]|[а-я]');

    if (!(passRegex.allMatches(value).length == 1)) {
      return AppStrings.passwordNotValid;
    }
    if (value.trim().length < 8) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }

  static DateTime _adultDateTimeFromString(String value) {
    if (value.length < 10) {
      throw FormatException();
    }
    RegExp regex = RegExp(r"(\d{2})-(\d{2})-(\d{4})");
    Match match = regex.firstMatch(value);
    int day = int.parse(match.group(1));
    int month = int.parse(match.group(2));
    int year = int.parse(match.group(3));
    DateTime adult = DateTime(year + 18, month, day);

    if (adult.day == day && adult.month == month && adult.year == year + 18) {
      return adult;
    }
    throw FormatException();
  }

  static String birthDayValidation(String value) {
    if (value.isEmpty) //Т.к. поле опционально сам по себе.
    {
      return null;
    }
    try {
      DateTime adult = _adultDateTimeFromString(value);
      if (adult.isAfter(DateTime.now())) {
        return AppStrings.tooYoung;
      }
    } on FormatException {
      return AppStrings.incorrectDate;
    }

    return null;
  }

  static String nameValidator(String value) {
    if (value.isEmpty) {
      return AppStrings.emptyName;
    }
    return null;
  }

  static bool allValidated(List<GlobalKey<FormState>> keys) {
    bool valid = true;
    keys.forEach((element) {
      valid = (valid && element.currentState.validate());
    });
    return valid;
  }
}
