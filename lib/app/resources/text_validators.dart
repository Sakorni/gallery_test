import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:intl/intl.dart';

class TextValidators {
  static String emailValidatior(String value) {
    if (!value.contains('@')) {
      return "Email should contatin a '@'!";
    }
    return null;
  }

  static String passwordValidator(String value) {
    if (!value.contains(RegExp(r'[A-Z]|[А-Я]'))) {
      return "Password should contain at least 1 captial letter!";
    }
    if (value.trim().length < 8) {
      return "Password is too short!";
    }
    return null;
  }

  static DateTime _adultDateTimeFromString(String value) {
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
        return "You should be at least 18 years old!";
      }
    } on FormatException {
      return "Incorrect date value!";
    }

    return null;
  }

  static String nameValidator(String value) {
    if (value.trim().length < 2) {
      return "Name is too short!";
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
