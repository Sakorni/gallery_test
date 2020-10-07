import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) action;
  final String labelText;
  final bool optional;
  final bool lastField;
  final FocusNode focusNode;
  final IconData icon;

  const TextInputField(
      {Key key,
      this.controller,
      this.action,
      this.focusNode,
      this.icon,
      this.labelText,
      this.lastField = false,
      this.optional = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 36,
      child: TextFormField(
        focusNode: focusNode,
        textInputAction: lastField ? TextInputAction.done : TextInputAction.go,
        onFieldSubmitted: action,
        controller: controller,
        textAlign: TextAlign.justify,
        decoration: InputDecoration(
            labelText: labelText,
            suffixText: optional ? "" : "*",
            suffixStyle: TextStyle(color: Colors.red),
            contentPadding: EdgeInsets.all(8),
            suffixIcon: Icon(
              icon,
              size: 30,
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }
}
