import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_test/app/resources/app_strings.dart';

class DateFormatter extends TextInputFormatter {
  static const int _limit = 8; //01.02.1998
  String _text;
  final _pattern = RegExp(r'\d');
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    _text = _format(value: newValue.text);
    return newValue.copyWith(text: _text, selection: updateCursorPosition());
  }

  String _format(
      {@required String value, String separator = AppStrings.separator}) {
    value = value.replaceAll(separator, '');
    var newString = '';
    for (int i = 0; i < min(value.length, _limit); i++) {
      if (_pattern.hasMatch(value[i])) {
        newString += value[i];
        if ((i == 1 || i == 3) && i != value.length - 1) {
          newString += separator;
        }
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition() {
    return TextSelection.fromPosition(TextPosition(offset: _text.length));
  }
}
