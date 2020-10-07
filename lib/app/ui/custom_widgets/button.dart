import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyButton extends StatelessWidget {
  final String caption;
  final Color backGroundColor;
  final Color textColor;
  final Function() onPressed;
  final bool outlined;

  const MyButton(
      {Key key,
      @required this.caption,
      this.backGroundColor,
      this.textColor,
      this.onPressed,
      this.outlined = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: backGroundColor,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: outlined ? BorderSide() : BorderSide.none),
      child: Text(
        caption,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
