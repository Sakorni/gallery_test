import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';

class TopBarTextStyles {
  static const TextStyle disabled = TextStyle(
    color: AppColors.mainGray,
    fontSize: 17,
  );
  static const TextStyle enabled = TextStyle(color: Colors.black);
}

class TopBarBoxDecoration {
  static const BoxDecoration disabled = BoxDecoration(
    border: Border(),
  );
  static const BoxDecoration enabled = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 2.0,
        color: AppColors.underLineColor,
      ),
    ),
  );
}
