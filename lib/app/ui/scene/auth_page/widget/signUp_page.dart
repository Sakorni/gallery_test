import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/auth_bloc.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/utils/text_validators.dart';
import 'package:gallery_test/app/ui/custom_widgets/action_button.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/screen_title.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/text_input_field.dart';

final _nameNode = FocusNode();
final _birthDayNode = FocusNode();
final _emailNode = FocusNode();
final _oldPwd = FocusNode();
final _confirmPwd = FocusNode();
final Key _nameKey = GlobalKey<FormState>();
final Key _bDayKey = GlobalKey<FormState>();
final Key _emailKey = GlobalKey<FormState>();
final Key _oldPwdKey = GlobalKey<FormState>();
final Key _confirmPwdKey = GlobalKey<FormState>();

class SignUpPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _birthDayController = TextEditingController();
  final _emailController = TextEditingController();
  final _oldPwdController = TextEditingController();
  final _confirmPwdController = TextEditingController();
  final void Function() swapScreens;

  final List<FocusNode> nodes = [
    _nameNode,
    _birthDayNode,
    _emailNode,
    _oldPwd,
    _confirmPwd
  ];
  final List<GlobalKey<FormState>> _keys = [
    _nameKey,
    _bDayKey,
    _emailKey,
    _oldPwdKey,
    _confirmPwdKey
  ];

  void _signUp(BuildContext context) {
    if (TextValidators.allValidated(_keys)) {
      BlocProvider.of<AuthBloc>(context).add(SignUp(
          name: _nameController.text,
          email: _emailController.text,
          oldPassword: _oldPwdController.text,
          confirmPassword: _confirmPwdController.text,
          bDayDate: _birthDayController.text));
    }
  }

  void nextNode(int i) => nodes[i + 1].requestFocus();

  SignUpPage({
    this.swapScreens,
  });
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ScreenTitle(
        text: AppStrings.signUp,
      ),
      SizedBox(height: 47),
      TextInputField.nameField(
        validKey: _keys[0],
        action: (_) => nextNode(0),
        focusNode: nodes[0],
        controller: _nameController,
      ),
      SizedBox(height: 10),
      TextInputField.bDayField(
        validKey: _keys[1],
        action: (_) => nextNode(1),
        focusNode: nodes[1],
        controller: _birthDayController,
      ),
      SizedBox(height: 10),
      TextInputField.emailField(
        validKey: _keys[2],
        action: (_) => nextNode(2),
        focusNode: nodes[2],
        controller: _emailController,
      ),
      SizedBox(height: 10),
      TextInputField.passwordField(
        validKey: _keys[3],
        labelText: AppStrings.oldPassHint,
        lastField: false,
        action: (_) => nextNode(3),
        controller: _oldPwdController,
        focusNode: nodes[3],
      ),
      SizedBox(height: 10),
      TextInputField.passwordField(
        validKey: _keys[4],
        labelText: AppStrings.confirmPassHint,
        action: (_) => _signUp(context),
        focusNode: nodes[4],
        controller: _confirmPwdController,
        lastField: true,
      ),
      Center(
        child: ActionButton(
            caption: AppStrings.signUp,
            backGroundColor: Colors.black,
            textColor: Colors.white,
            onPressed: () => _signUp(context)),
      ),
      Center(
        child: ActionButton(
          caption: AppStrings.signIn,
          backGroundColor: Colors.white,
          textColor: Colors.black,
          onPressed: swapScreens,
          outlined: false,
        ),
      )
    ]);
  }
}
