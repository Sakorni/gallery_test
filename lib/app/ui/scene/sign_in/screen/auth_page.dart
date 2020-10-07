import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/data/gateway/auth_mode.dart';

class AuthPage extends StatelessWidget {
  final bool signIn;

  const AuthPage(
    AuthMode mode, {
    Key key,
  })  : signIn = mode == AuthMode.signIn,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: FlatButton(),
          backgroundColor: Colors.white,
          elevation: 0,
          shape: Border(
            bottom: BorderSide(
              color: AppColors.appBarShapeColor,
            ),
          ),
        ),
      ),
    );
  }
}
