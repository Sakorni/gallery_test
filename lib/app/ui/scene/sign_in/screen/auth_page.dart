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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          excludeFromSemantics: true,
          onTap: () => Navigator.pop(context),
          child: Text("Cancel",
              style: TextStyle(color: Color(0xFF5f5f5f), fontSize: 15),
              textAlign: TextAlign.justify),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: Border(
          bottom: BorderSide(
            color: AppColors.appBarShapeColor,
          ),
        ),
      ),
    );
  }
}
