import 'package:flutter/widgets.dart';

/// TODO
/// это не ресурсы, это вспомогательное для логики
class TextValidators {
  static String emailValidatior(String value) {
    if (!value.contains('@')) {
      return "Email should contatin a '@'!";
    }
    return null;
  }

  static String passwordValidator(String value) {
    /// TODO ???
    /// прописная, и одна, а не от одной и более
    if (!value.contains(RegExp(r'[A-Z]|[А-Я]'))) {
      return "Password should contain at least 1 captial letter!";
    }
    if (value.trim().length < 8) {
      return "Password is too short!";
    }
    return null;
  }

  static DateTime _adultDateTimeFromString(String value) {
    /// TODO ???
    /// ввёл два символа в дату, ошибку не выдало в ui
    ///
    /// The method 'group' was called on null.
    /// Receiver: null
    /// Tried calling: group(1)
    ///
    /// дд.мм.гггг
    RegExp regex = RegExp(r"(\d{2})-(\d{2})-(\d{4})");
    Match match = regex.firstMatch(value);
    int day = int.parse(match.group(1));
    int month = int.parse(match.group(2));
    int year = int.parse(match.group(3));
    DateTime adult = DateTime(year + 18, month, day);
    /// DateTime.difference(otherDateTime)
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
    /// TODO ???
    /// не пустое
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
