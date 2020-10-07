import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_test/app/resources/app_colors.dart';

class TextInputField extends StatefulWidget {
  final String labelText;
  final String asset;
  final bool optional;
  final bool lastField;
  final bool hidden;
  final GlobalKey<FormState> validKey;
  final TextEditingController controller;
  final TextInputType inputType;
  final IconData icon;
  final FocusNode focusNode;
  final String Function(String) validator;
  final void Function(String) action;

  const TextInputField({
    this.validKey,
    this.controller,
    this.action,
    this.focusNode,
    this.icon,
    this.labelText,
    this.inputType,
    this.asset,
    this.validator,
    this.lastField = false,
    this.optional = false,
    this.hidden = false,
  });

  @override
  _TextInputFieldState createState() => _TextInputFieldState(hidden);
}

class _TextInputFieldState extends State<TextInputField> {
  bool isHidden;
  bool passwordField = false;
  void showPwd() {
    if (passwordField)
      setState(() {
        isHidden = !isHidden;
      });
  }

  _TextInputFieldState(this.isHidden) {
    passwordField = isHidden;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: widget.validKey,
        child: TextFormField(
          keyboardType: widget.inputType,
          focusNode: widget.focusNode,
          validator: widget.validator,
          textInputAction:
              widget.lastField ? TextInputAction.done : TextInputAction.go,
          onFieldSubmitted: widget.action,
          controller: widget.controller,
          textAlign: TextAlign.justify,
          obscureText: isHidden,
          decoration: InputDecoration(
              labelText: widget.labelText,
              suffixText: widget.optional ? "" : "*", // TODO: Разобраться с ним
              suffixStyle: TextStyle(color: Colors.red),
              contentPadding: EdgeInsets.all(8),
              suffixIcon: GestureDetector(
                excludeFromSemantics: true,
                onTap: showPwd,
                child: widget.icon != null
                    ? Icon(
                        widget.icon,
                        color: AppColors.appBarShapeColor,
                        size: 30,
                      )
                    : Image.asset(
                        widget.asset,
                        color: AppColors.appBarShapeColor,
                        width: 30,
                        height: 30,
                      ),
              ),
              border: OutlineInputBorder(borderSide: BorderSide())),
        ),
      ),
    );
  }
}
