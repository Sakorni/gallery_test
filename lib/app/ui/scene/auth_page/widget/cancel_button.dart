import 'package:flutter/cupertino.dart';
import 'package:gallery_test/app/resources/app_colors.dart';

class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTap: () => Navigator.pop(context),
      child: Text("Cancel",
          style: TextStyle(color: AppColors.cancelButtonColor, fontSize: 15),
          textAlign: TextAlign.justify),
    );
  }
}
