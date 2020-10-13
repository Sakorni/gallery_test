import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';

class UnderPictureField extends StatelessWidget {
  final String leftField;
  final String rightField;
  final TextStyle style;
  final bool views;
  static const TextStyle subStyle = TextStyle(
    fontSize: 12,
    color: AppColors.mainGray,
  );

  UnderPictureField.authorAndDate({String author, DateTime date})
      : style = TextStyle(
          fontSize: 15,
          color: AppColors.mainGray,
        ),
        leftField = author,
        rightField = "${date.day}.${date.month}.${date.year}",
        views = true;

  UnderPictureField.nameAndViews({String name, int views})
      : style = TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        leftField = name,
        rightField = views.toString(),
        views = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(leftField, style: style),
        Row(
          children: [
            Text(rightField, style: subStyle),
            views
                ? Image.asset(
                    AssetImagePath.eyeIcon,
                    width: 13,
                    height: 13,
                  )
                : Container(),
          ],
        )
      ],
    );
  }
}
