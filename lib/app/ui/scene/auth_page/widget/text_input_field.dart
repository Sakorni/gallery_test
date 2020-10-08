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
  bool shouldCallDateTimePicker;
  bool pickedDate = true;
  DateTime date = DateTime.now();
  bool shouldPickDate() {
    if (widget.dateTime) {
      if (widget.focusNode.hasFocus) {
        if (shouldCallDateTimePicker || pickedDate) {
          return true;
        }
      }
    }
    return false;
  }

  void showPwd() {
    if (widget.showOnEyeClick)
      setState(() {
        isHidden = !isHidden;
      });
  }

  Future<void> pickTime() async {
    shouldCallDateTimePicker = false;
    FocusScope.of(context).requestFocus(new FocusNode());
    DateTime picked = await showDatePicker(
        context: context,
        firstDate: DateTime.utc(date.year - 100),
        initialDate: date,
        lastDate: DateTime.utc(date.year + 100));
    if (picked != null && picked != date) {
      date = picked;
      widget.controller.text =
          "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      setState(() {
        pickedDate = true;
      });
    }
  }

  @override
  void initState() {
    shouldCallDateTimePicker = widget.dateTime;
    isHidden = widget.hidden;
    widget.focusNode.addListener(() async {
      if (shouldPickDate()) {
        await pickTime();
        shouldCallDateTimePicker = true;
      }
    });
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
          readOnly: widget.dateTime,
          validator: widget.validator,
          textInputAction:
              widget.lastField ? TextInputAction.done : TextInputAction.go,
          onFieldSubmitted: widget.action,
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
