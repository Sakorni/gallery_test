import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/text_input_field.dart';
import 'package:gallery_test/app/ui/scene/profile_page/widgets/circled_photo.dart';
import 'package:gallery_test/data/entity/firebase_user.dart';

class SettingsPage extends StatelessWidget {
  final FirebaseUser user;
  final nameKey = GlobalKey<FormState>();
  final nameNode = FocusNode();
  final nameController;

  final bDayKey = GlobalKey<FormState>();
  final bDayNode = FocusNode();
  final bDayController;

  final emailKey = GlobalKey<FormState>();
  final emailNode = FocusNode();
  final emailController;

  final oldPwdKey = GlobalKey<FormState>();
  final oldPwdNode = FocusNode();
  final oldPwdController;

  final newPwdKey = GlobalKey<FormState>();
  final newPwdNode = FocusNode();
  final newPwdController;

  final confirmPwdKey = GlobalKey<FormState>();
  final confirmPwdNode = FocusNode();
  final confirmPwdController;

  List<GlobalKey<FormState>> dataKeys;

  void dropFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  SettingsPage(this.user)
      : nameController = TextEditingController(text: user.name),
        bDayController = TextEditingController(text: user.dayOfBirth),
        emailController = TextEditingController(text: user.email),
        oldPwdController = TextEditingController(),
        newPwdController = TextEditingController(),
        confirmPwdController = TextEditingController() {
    dataKeys = [
      nameKey,
      bDayKey,
      emailKey,
      confirmPwdController,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          FlatButton(
            onPressed: () => print("TappedSave!!!"),
            child: Text(
              "Save",
              style: TextStyle(
                color: AppColors.underLineColor,
                fontSize: 15,
              ),
            ),
          )
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            CircledPhoto(size: 100),
            Center(
              child: Text(
                "Upload photo",
                style: TextStyle(fontSize: 12, color: AppColors.mainGray),
              ),
            ),
            Text("Personal data"),
            TextInputField.nameField(
                optional: true,
                validKey: nameKey,
                action: (_) => dropFocus(context),
                focusNode: nameNode,
                controller: nameController),
            TextInputField.bDayField(
                optional: true,
                validKey: bDayKey,
                action: (_) => dropFocus(context),
                focusNode: bDayNode,
                controller: bDayController),
            Text("E-mail address"),
            TextInputField.emailField(
                optional: true,
                validKey: emailKey,
                action: (_) => dropFocus(context),
                focusNode: emailNode,
                controller: emailController),
            Text("Password"),
            TextInputField.passwordField(
              optional: true,
              action: (_) => dropFocus(context),
              focusNode: oldPwdNode,
              controller: oldPwdController,
              labelText: AppStrings.oldPassHint,
              lastField: false,
              validKey: oldPwdKey,
            ),
            TextInputField.passwordField(
              optional: true,
              action: (_) => dropFocus(context),
              focusNode: newPwdNode,
              controller: newPwdController,
              labelText: AppStrings.newPassHint,
              lastField: false,
              validKey: newPwdKey,
            ),
            TextInputField.passwordField(
              optional: true,
              action: (_) => dropFocus(context),
              focusNode: confirmPwdNode,
              controller: confirmPwdController,
              labelText: AppStrings.confirmPassHint,
              lastField: true,
              validKey: confirmPwdKey,
            ),
          ],
        ),
      ),
    );
  }
}
