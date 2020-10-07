import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/custom_widgets/button.dart';
import 'package:gallery_test/app/ui/scene/sign_in/screen/auth_page.dart';
import 'package:gallery_test/data/gateway/auth_mode.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ActionButton(
              caption: AppStrings.createAcc,
              onPressed: () {
                print("Click!");
              },
              backGroundColor: AppColors.firstColor,
              textColor: AppColors.secondColor,
            ),
            ActionButton(
              caption: AppStrings.haveAcc,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthPage(AuthMode.signIn)),
                );
              },
              backGroundColor: AppColors.secondColor,
              textColor: AppColors.firstColor,
            )
          ],
        ),
      ),
    );
  }
}
