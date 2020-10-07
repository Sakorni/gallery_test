import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/custom_widgets/action_button.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/text_input_field.dart';

final _nameNode = FocusNode();
final _birthDayNode = FocusNode();
final _emailNode = FocusNode();
final _oldPwd = FocusNode();
final _confirmPwd = FocusNode();

class SignUpPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _birthDayController = TextEditingController();
  final _emailController = TextEditingController();
  final _oldPwdController = TextEditingController();
  final _confirmPwdController = TextEditingController();

  List<FocusNode> nodes = [
    _nameNode,
    _birthDayNode,
    _emailNode,
    _oldPwd,
    _confirmPwd
  ];
  void nextNode(int i) => nodes[i + 1].requestFocus();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextInputField(
          inputType: TextInputType.name,
          labelText: "Name",
          asset: "assets/person_icon.png",
          action: (_) => nextNode(0),
          controller: _nameController,
          optional: false,
          focusNode: nodes[0]),
      SizedBox(height: 10),
      TextInputField(
        inputType: TextInputType.datetime,
        key: Key("Birthday"),
        labelText: "Birthday",
        icon: CupertinoIcons.calendar,
        action: (_) => nextNode(1),
        controller: _birthDayController,
        focusNode: nodes[1],
      ),
      SizedBox(height: 10),
      TextInputField(
          inputType: TextInputType.emailAddress,
          labelText: "Email",
          icon: CupertinoIcons.mail,
          action: (_) => nextNode(2),
          controller: _emailController,
          optional: false,
          focusNode: nodes[2]),
      SizedBox(height: 10),
      TextInputField(
        inputType: TextInputType.visiblePassword,
        labelText: "OldPassword",
        asset: "assets/eye_icon.png",
        action: (_) => nextNode(3),
        controller: _oldPwdController,
        focusNode: nodes[3],
        optional: false,
        hidden: true,
      ),
      SizedBox(height: 10),
      TextInputField(
        inputType: TextInputType.visiblePassword,
        labelText: "Confirm password",
        asset: "assets/eye_icon.png",
        action: (_) => print("Done!"),
        controller: _confirmPwdController,
        focusNode: nodes[4],
        lastField: true,
        optional: false,
        hidden: true,
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
