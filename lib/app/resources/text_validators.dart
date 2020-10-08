import 'package:flutter/widgets.dart';
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

  static String birthDayValidation(String value) {
    if (value.isEmpty) //Т.к. поле опционально сам по себе.
    {
      return null;
    }
    String datePattern = "dd-MM-yyyy";
    DateTime bDay = DateFormat(datePattern).parse(value);
    DateTime adult = DateTime(bDay.year + 18, bDay.month, bDay.day);
    if (adult.isAfter(DateTime.now())) {
      return "You should be at least 18 years old!";
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
