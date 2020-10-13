import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_strings.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/utils/text_validators.dart';

class PhotoTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final GlobalKey<FormState> validKey;
  final void Function() action;
  final String Function(String) validator;
  final int lines;

  const PhotoTextField.nameField(
      {@required this.controller,
      @required this.focusNode,
      @required this.validKey,
      @required this.action})
      : this.hintText = AppStrings.nameHint,
        this.lines = 1,
        this.validator = TextValidators.nameValidator;
  PhotoTextField.descriptionField(
      {@required this.controller,
      @required this.focusNode,
      @required this.validKey,
      @required this.action})
      : this.hintText = "Description",
        this.lines = 4,
        this.validator = TextValidators.empty;
  @override
  _PhotoTextFieldState createState() => _PhotoTextFieldState();
}

class _PhotoTextFieldState extends State<PhotoTextField> {
  _action(String text) {
    widget.validKey.currentState.validate();
    widget.action();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: widget.validKey,
        child: TextFormField(
          minLines: widget.lines,
          maxLines: widget.lines,
          keyboardType: TextInputType.multiline,
          focusNode: widget.focusNode,
          validator: widget.validator,
          textInputAction: TextInputAction.go,
          onFieldSubmitted: _action,
          controller: widget.controller,
          textAlign: TextAlign.justify,
          decoration: InputDecoration(
              hintText: widget.hintText,
              suffixStyle: TextStyle(color: Colors.red),
              contentPadding: EdgeInsets.all(8),
              border: OutlineInputBorder(borderSide: BorderSide())),
        ),
      ),
    );
  }
}
