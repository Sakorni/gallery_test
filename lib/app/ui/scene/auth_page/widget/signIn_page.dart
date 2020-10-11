import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/utils/text_validators.dart';
import 'package:gallery_test/app/ui/custom_widgets/action_button.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/forgot_lgn_or_pwd.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/screen_title.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/text_input_field.dart';

final loginNode = FocusNode();
final passwordNode = FocusNode();
final _emailKey = GlobalKey<FormState>();
final _pwdKey = GlobalKey<FormState>();

class SignInPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<GlobalKey<FormState>> keys = [_emailKey, _pwdKey];
  final void Function({String email, String password}) signIn;
  final void Function() swapScreens;

  SignInPage({Key key, this.signIn, this.swapScreens}) : super(key: key);
  void _signIn() {
    if (TextValidators.allValidated(keys)) {
      signIn(email: _emailController.text, password: _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ScreenTitle(
        text: AppStrings.signIn,
      ),
      SizedBox(height: 47),
      TextInputField.emailField(
        validKey: keys[0],
        action: (_) => passwordNode.requestFocus(),
        focusNode: loginNode,
        controller: _emailController,
      ),
      SizedBox(height: 10),
      TextInputField.passwordField(
        validKey: keys[1],
        labelText: AppStrings.passwordHint,
        action: (_) => _signIn(),
        lastField: true,
        focusNode: passwordNode,
        controller: _passwordController,
      ),
      ForgotLgnPwd(
        action: () => print("Forgot!"),
      ),
      Center(
        child: ActionButton(
            caption: AppStrings.signIn,
            backGroundColor: Colors.black,
            textColor: Colors.white,
            onPressed: _signIn),
      ),
      Center(
        child: ActionButton(
          caption: AppStrings.signUp,
          backGroundColor: Colors.white,
          textColor: Colors.black,
          onPressed: swapScreens,
          outlined: false,
        ),
      )
    ]);
  }
}
