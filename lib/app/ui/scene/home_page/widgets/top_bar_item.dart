import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';

class TopBarItem extends StatelessWidget {
  final bool enabled;
  final void Function() selectIndex;
  final String text;

  TopBarItem({this.enabled, this.selectIndex, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: enabled
            ? Border(
                bottom: BorderSide(
                  width: 2.0,
                  color: AppColors.underLineColor,
                ),
              )
            : Border(),
      ),
      child: FlatButton(
        onPressed: () => selectIndex(),
        child: Text(
          text,
          style: enabled
              ? TextStyle(color: Colors.black)
              : TextStyle(
                  color: AppColors.mainGray,
                ),
        ),
      ),
    );
  }
}
