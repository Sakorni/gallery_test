import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_test/app/resources/app_colors.dart';

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

  void showPwd() {
    if (widget.showOnEyeClick)
      setState(() {
        isHidden = !isHidden;
      });
  }

  void pickTime() async {
    DateTime date = DateTime.now();
    FocusScope.of(context).requestFocus(new FocusNode());

    DateTime picked = await showDatePicker(
        context: context,
        firstDate: DateTime.utc(date.year - 100),
        initialDate: date,
        lastDate: DateTime.utc(date.year + 100));
    if (picked != null && picked != date) {
      widget.controller.text =
          "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      setState(() {});
    }
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: widget.validKey,
        child: TextFormField(
          keyboardType: widget.inputType,
          onTap: widget.dateTime ? pickTime : null,
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
