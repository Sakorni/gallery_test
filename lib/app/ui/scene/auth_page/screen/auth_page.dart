import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/custom_widgets/action_button.dart';
import 'package:gallery_test/app/ui/scene/auth_page/screen/signUp_page.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/cancel_button.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/forgot_lgn_or_pwd.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/screen_title.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/text_input_field.dart';
import 'package:gallery_test/data/gateway/auth_mode.dart';

final loginNode = FocusNode();
final passwordNode = FocusNode();
final _emailKey = GlobalKey<FormState>();
final _pwdKey = GlobalKey<FormState>();

class AuthPage extends StatelessWidget {
  final bool signIn;

  const AuthPage(
    AuthMode mode, {
    Key key,
  })  : signIn = mode == AuthMode.signIn,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: CancelButton(),
            backgroundColor: Colors.white,
            elevation: 0,
            shape: Border(
              bottom: BorderSide(
                color: AppColors.appBarShapeColor,
              ),
            ),
          ),
          body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                SizedBox(
                  height: 100,
                ),
                ScreenTitle(
                    text: signIn ? AppStrings.signIn : AppStrings.signUp),
                SizedBox(height: 47),
                signIn ? SignInPage() : SignUpPage(),
              ])),
    );
  }
}

String emailValidatior(String value) {
  if (!value.contains('@')) {
    return "Email should contatin a '@'!";
  }
  return null;
}

String passwordValidator(String value) {
  if (!value.contains(RegExp(r'[A-Z]|[А-Я]'))) {
    return "Password should contain at least 1 captial letter!";
  }
  if (!(value.length > 7)) {
    return "Password is too short!";
  }
  return null;
}

class SignInPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<GlobalKey<FormState>> keys = [_emailKey, _pwdKey];
    return Column(children: [
      TextInputField(
        validator: emailValidatior,
        validKey: keys[0],
        inputType: TextInputType.emailAddress,
        labelText: "Email",
        icon: CupertinoIcons.mail,
        action: (_) => passwordNode.requestFocus(),
        controller: _emailController,
        focusNode: loginNode,
      ),
      SizedBox(height: 10),
      TextInputField(
        validator: passwordValidator,
        validKey: keys[1],
        inputType: TextInputType.visiblePassword,
        labelText: "Password",
        asset: "assets/eye_icon.png",
        action: (_) => print("Done!"),
        controller: _passwordController,
        lastField: true,
        focusNode: passwordNode,
        hidden: true,
      ),
      ForgotLgnPwd(
        action: () => print("Forgot!"),
      ),
      Center(
        child: ActionButton(
          caption: AppStrings.signIn,
          backGroundColor: Colors.black,
          textColor: Colors.white,
          onPressed: () {
            print("Pressed Sign In");
          },
        ),
      ),
      Center(
        child: ActionButton(
          caption: AppStrings.signUp,
          backGroundColor: Colors.white,
          textColor: Colors.black,
          onPressed: () {
            print(keys[0].currentState.validate());
          },
          outlined: false,
        ),
      )
    ]);
  }
}
