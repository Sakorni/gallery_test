import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String) action;
  final String labelText;
  final bool optional;
  final bool lastField;
  final FocusNode focusNode;
  final IconData icon;
  final bool hidden;

  const TextInputField(
      {Key key,
      this.controller,
      this.action,
      this.focusNode,
      this.icon,
      this.labelText,
      this.lastField = false,
      this.optional = false,
      this.hidden = false})
      : super(key: key);

  @override
  _TextInputFieldState createState() => _TextInputFieldState(hidden);
}

class _TextInputFieldState extends State<TextInputField> {
  bool isHidden;
  bool passwordField = false;
  _TextInputFieldState(this.isHidden) {
    passwordField = isHidden;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 36,
      child: TextFormField(
        focusNode: widget.focusNode,
        textInputAction:
            widget.lastField ? TextInputAction.done : TextInputAction.go,
        onFieldSubmitted: widget.action,
        controller: widget.controller,
        textAlign: TextAlign.justify,
        obscureText: isHidden,
        decoration: InputDecoration(
            labelText: widget.labelText,
            suffixText: widget.optional ? "" : "*",
            suffixStyle: TextStyle(color: Colors.red),
            contentPadding: EdgeInsets.all(8),
            suffixIcon: GestureDetector(
              excludeFromSemantics: true,
              onTap: passwordField
                  ? () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    }
                  : null,
              child: Icon(
                widget.icon,
                size: 30,
              ),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }
}
