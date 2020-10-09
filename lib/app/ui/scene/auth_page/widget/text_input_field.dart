import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/ui/scene/auth_page/widget/date_formatter.dart';

class TextInputField extends StatefulWidget {
  final String labelText;
  final String asset;
  final bool optional;
  final bool lastField;
  final bool hidden;
  final bool showOnEyeClick;
  final bool dateTime;
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
    this.dateTime = false,
    this.lastField = false,
    this.optional = false,
    this.hidden = false,
    this.showOnEyeClick = false,
  });

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool isHidden;
  _action(String text) {
    widget.validKey.currentState.validate();
    widget.action('');
  }

  DateTime date = DateTime.now();
  void showPwd() {
    if (widget.showOnEyeClick)
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
