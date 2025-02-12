import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/custom_widgets/action_button.dart';
import 'package:gallery_test/app/ui/custom_widgets/logo_picture.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/auth_bloc.dart';
import 'package:gallery_test/app/ui/scene/auth_page/screen/auth_page.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void navigateToAuth({bool signIn}) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => AuthBloc(),
                  child: AuthPage(signIn),
                )),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LogoPicture(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text(
                  AppStrings.welcome,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ActionButton(
              caption: AppStrings.createAcc,
              onPressed: () => navigateToAuth(signIn: false),
              backGroundColor: Colors.black,
              textColor: Colors.white,
            ),
            ActionButton(
              caption: AppStrings.haveAcc,
              onPressed: () => navigateToAuth(signIn: true),
              backGroundColor: Colors.white,
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
