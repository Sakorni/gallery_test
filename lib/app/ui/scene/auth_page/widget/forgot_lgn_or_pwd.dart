import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/app_strings.dart';

class ForgotLgnPwd extends StatelessWidget {
  final Function() action;

  const ForgotLgnPwd({Key key, this.action}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: action,
          child: Text(
            AppStrings.forgot,
            style: TextStyle(fontSize: 13, color: AppColors.mainGray),
          ),
        ));
  }
}
