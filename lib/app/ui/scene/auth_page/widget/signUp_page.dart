import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';
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
  final void Function(
      {String name,
      String email,
      String password,
      String confirmPassword,
      String bDay}) signUp;
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

  SignUpPage({Key key, this.swapScreens, this.signUp}) : super(key: key);

  void _signUp() {
    if (TextValidators.allValidated(_keys)) {
      signUp(
          name: _nameController.text,
          email: _emailController.text,
          password: _oldPwdController.text,
          confirmPassword: _confirmPwdController.text,
          bDay: _birthDayController.text);
    }
  }

  void nextNode(int i) => nodes[i + 1].requestFocus();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ScreenTitle(
        text: AppStrings.signUp,
      ),
      SizedBox(height: 47),
      TextInputField(
          validKey: _keys[0],
          validator: TextValidators.nameValidator,
          inputType: TextInputType.name,
          labelText: AppStrings.nameHint,
          asset: AssetImagePath.personIcon,
          action: (_) => nextNode(0),
          controller: _nameController,
          focusNode: nodes[0]),
      SizedBox(height: 10),
      TextInputField(
        validKey: _keys[1],
        validator: TextValidators.birthDayValidation,
        inputType: TextInputType.datetime,
        labelText: AppStrings.bDayHint,
        dateTime: true,
        asset: AssetImagePath.calendarIcon,
        action: (_) => nextNode(1),
        controller: _birthDayController,
        focusNode: nodes[1],
        optional: true,
      ),
      SizedBox(height: 10),
      TextInputField(
          validKey: _keys[2],
          validator: TextValidators.emailValidatior,
          inputType: TextInputType.emailAddress,
          labelText: AppStrings.emailHint,
          asset: AssetImagePath.emailIcon,
          action: (_) => nextNode(2),
          controller: _emailController,
          focusNode: nodes[2]),
      SizedBox(height: 10),
      TextInputField(
        validKey: _keys[3],
        validator: TextValidators.passwordValidator,
        inputType: TextInputType.visiblePassword,
        labelText: AppStrings.oldPassHint,
        asset: AssetImagePath.eyeIcon,
        action: (_) => nextNode(3),
        controller: _oldPwdController,
        focusNode: nodes[3],
        hidden: true,
      ),
      SizedBox(height: 10),
      TextInputField(
        validKey: _keys[4],
        validator: TextValidators.passwordValidator,
        inputType: TextInputType.visiblePassword,
        labelText: AppStrings.confirmPassHint,
        asset: AssetImagePath.eyeIcon,
        action: (_) => _signUp(),
        controller: _confirmPwdController,
        focusNode: nodes[4],
        lastField: true,
        hidden: true,
      ),
      Center(
        child: ActionButton(
            caption: AppStrings.signUp,
            backGroundColor: Colors.black,
            textColor: Colors.white,
            onPressed: _signUp),
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
