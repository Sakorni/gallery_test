import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/custom_widgets/action_button.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/forgot_lgn_or_pwd.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/text_input_field.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final loginNode = FocusNode();
    final passwordNode = FocusNode();

    return Column(children: [
      TextInputField(
        inputType: TextInputType.emailAddress,
        labelText: "Email",
        icon: CupertinoIcons.mail,
        action: (_) => passwordNode.requestFocus(),
        controller: _emailController,
        focusNode: loginNode,
      ),
      SizedBox(height: 10),
      TextInputField(
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
            print("Pressed SignUp");
          },
          outlined: false,
        ),
      )
    ]);
  }
}
