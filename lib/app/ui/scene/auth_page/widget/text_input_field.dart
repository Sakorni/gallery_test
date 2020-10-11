import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/utils/text_validators.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/date_formatter.dart';

class TextInputField extends StatefulWidget {
  final String labelText;
  final String asset;
  final bool optional;
  final bool lastField;
  final bool hidden;
  final bool dateTime;
  final GlobalKey<FormState> validKey;
  final TextEditingController controller;
  final TextInputType inputType;
  final FocusNode focusNode;
  final String Function(String) validator;
  final void Function(String) action;

  TextInputField({
    this.validKey,
    this.controller,
    this.action,
    this.focusNode,
    this.labelText,
    this.inputType,
    this.asset,
    this.validator,
    this.dateTime = false,
    this.lastField = false,
    this.optional = false,
    this.hidden = false,
  });
  TextInputField.nameField({
    @required this.validKey,
    @required this.action,
    @required this.focusNode,
    @required this.controller,
  })  : validator = TextValidators.nameValidator,
        inputType = TextInputType.name,
        labelText = AppStrings.nameHint,
        optional = false,
        lastField = false,
        this.hidden = false,
        this.dateTime = false,
        asset = AssetImagePath.personIcon;
  TextInputField.bDayField({
    @required this.validKey,
    @required this.action,
    @required this.focusNode,
    @required this.controller,
  })  : validator = TextValidators.birthDayValidation,
        inputType = TextInputType.datetime,
        labelText = AppStrings.bDayHint,
        optional = true,
        lastField = false,
        this.hidden = false,
        this.dateTime = true,
        asset = AssetImagePath.calendarIcon;

  TextInputField.emailField({
    @required this.validKey,
    @required this.action,
    @required this.focusNode,
    @required this.controller,
  })  : validator = TextValidators.emailValidatior,
        inputType = TextInputType.emailAddress,
        labelText = AppStrings.emailHint,
        optional = false,
        lastField = false,
        this.hidden = false,
        this.dateTime = false,
        asset = AssetImagePath.emailIcon;

  TextInputField.passwordField({
    @required this.validKey,
    @required this.focusNode,
    @required this.controller,
    @required this.action,
    @required this.labelText,
    @required this.lastField,
  })  : validator = TextValidators.passwordValidator,
        inputType = TextInputType.visiblePassword,
        optional = false,
        this.hidden = true,
        this.dateTime = false,
        asset = AssetImagePath.eyeIcon;

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool isHidden;
  _action(String text) {
    widget.validKey.currentState.validate();
    widget.action('');
  }

  void showPwd() {
    if (widget.hidden)
      setState(() {
        isHidden = !isHidden;
      });
  }

  @override
  void initState() {
    isHidden = widget.hidden;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: widget.validKey,
        child: TextFormField(
          inputFormatters: widget.dateTime ? [DateFormatter()] : [],
          keyboardType: widget.inputType,
          focusNode: widget.focusNode,
          validator: widget.validator,
          textInputAction:
              widget.lastField ? TextInputAction.done : TextInputAction.go,
          onFieldSubmitted: _action,
          controller: widget.controller,
          textAlign: TextAlign.justify,
          obscureText: isHidden,
          decoration: InputDecoration(
              labelText: widget.labelText +
                  (widget.optional ? "" : "*"), // TODO: Разобраться с ним
              suffixStyle: TextStyle(color: Colors.red),
              contentPadding: EdgeInsets.all(8),
              suffixIcon: GestureDetector(
                excludeFromSemantics: true,
                onTap: showPwd,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Image.asset(
                    widget.asset,
                    color: AppColors.mainGray,
                    width: 22,
                    height: 22,
                  ),
                ),
              ),
              border: OutlineInputBorder(borderSide: BorderSide())),
        ),
      ),
    );
  }
}
