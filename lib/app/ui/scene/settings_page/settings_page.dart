import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/custom_widgets/error_snack_bar.dart';
import 'package:gallery_test/app/ui/custom_widgets/while_loading.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/utils/text_validators.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/text_input_field.dart';
import 'package:gallery_test/app/ui/scene/profile_page/widgets/circled_photo.dart';
import 'package:gallery_test/app/ui/scene/settings_page/bloc/settings_bloc.dart';
import 'package:gallery_test/app/ui/scene/welcome_screen/welcome_screen.dart';
import 'package:gallery_test/data/entity/firebase_user.dart';

class SettingsPage extends StatelessWidget {
  final nameKey = GlobalKey<FormState>();
  final nameNode = FocusNode();
  TextEditingController nameController;

  final bDayKey = GlobalKey<FormState>();
  final bDayNode = FocusNode();
  TextEditingController bDayController;

  final emailKey = GlobalKey<FormState>();
  final emailNode = FocusNode();
  TextEditingController emailController;

  final oldPwdKey = GlobalKey<FormState>();
  final oldPwdNode = FocusNode();
  TextEditingController oldPwdController;

  final newPwdKey = GlobalKey<FormState>();
  final newPwdNode = FocusNode();
  TextEditingController newPwdController;

  final confirmPwdKey = GlobalKey<FormState>();
  final confirmPwdNode = FocusNode();
  TextEditingController confirmPwdController;
  bool circular = false;

  List<GlobalKey<FormState>> dataKeys;

  void dropFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  SettingsBloc bloc;
  FirebaseUser user;

  SettingsPage() {
    dataKeys = [
      nameKey,
      bDayKey,
      emailKey,
    ];
  }

  void setData(BuildContext context) {
    bloc = BlocProvider.of<SettingsBloc>(context);
    user = bloc.user;
    nameController = TextEditingController(text: user.name);
    bDayController = TextEditingController(text: user.dayOfBirth);
    emailController = TextEditingController(text: user.email);
    oldPwdController = TextEditingController();
    newPwdController = TextEditingController();
    confirmPwdController = TextEditingController();
  }

  void _listener(BuildContext context, SettingsState state) {
    if (state is SettingsInitial && circular) {
      Navigator.of(context).pop();
      circular = false;
    }
    if (state is SettingsProccess) {
      showCircularwhileLoading(context);
      circular = true;
    } else if (state is SettingsError) {
      showErrorSnackBar(context, state.message);
    } else if (state is SettingsPopToWelcomeScreen) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => WelcomeScreen(),
          ),
          (route) => false);
    }
  }

  void signOut() {
    bloc.add(SignOut());
  }

  void deleteAccout(BuildContext context) async {
    bool delete = false;
    delete = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete your account?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("Yes")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("No"))
            ],
          );
        });
    if (delete) {
      bloc.add(DeleteAccount());
    }
  }

  void saveChages() {
    String name = nameController.text;
    String bDay = bDayController.text;
    String email = emailController.text;
    String oldPwd = oldPwdController.text;
    String newPwd = newPwdController.text;
    String confirmPwd = confirmPwdController.text;
    List<GlobalKey<FormState>> keys = [nameKey, bDayKey, emailKey];
    if (oldPwd.isNotEmpty && newPwd.isNotEmpty && confirmPwd.isNotEmpty) {
      keys.addAll([oldPwdKey, newPwdKey, confirmPwdKey]);
    }
    if (TextValidators.allValidated(keys))
      bloc.add(
        UpdateField(
            name: name,
            dayOfBirth: bDay,
            email: email,
            newPassword: newPwd,
            oldPassword: oldPwd,
            confirmPassword: confirmPwd),
      );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          FlatButton(
            onPressed: () {
              dropFocus(context);
              saveChages();
            },
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
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: _listener,
        builder: (context, state) {
          if (state is SettingsInitial) {
            setData(context);
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                SizedBox(height: 21),
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
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text("You can"),
                    GestureDetector(
                      onTap: () => deleteAccout(context),
                      child: Text(
                        " delete your account",
                        style: TextStyle(color: AppColors.underLineColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: signOut,
                  child: Text(
                    "Sign Out",
                    style: TextStyle(color: AppColors.underLineColor),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
