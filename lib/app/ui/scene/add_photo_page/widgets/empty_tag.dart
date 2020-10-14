import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_test/app/resources/app_colors.dart';

class EmptyTagField extends StatefulWidget implements Widget {
  final TextEditingController controller;
  final void Function() action;
  EmptyTagField({this.controller, this.action});

  @override
  _EmptyTagFieldState createState() => _EmptyTagFieldState();
}

class _EmptyTagFieldState extends State<EmptyTagField> {
  static const _minWidth = 80.0;
  InputBorder border = InputBorder.none;
  double width = _minWidth;
  @override
  void initState() {
    if (!widget.controller.hasListeners) {
      widget.controller.addListener(() {
        String text = widget.controller.text;
        if (text.length > 5) {
          setState(() {
            this.width = 300;
          });
        }
        if (text.isEmpty || text.length <= 5) {
          setState(() {
            this.width = _minWidth;
          });
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: width,
      // margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: AppColors.mainGray,
          ),
          Expanded(
            child: TextField(
              maxLines: 1,
              minLines: 1,
              controller: widget.controller,
              onSubmitted: (_) => widget.action(),
              inputFormatters: [_TagFormatter()],
              style: TextStyle(fontSize: 12, color: Colors.black),
              decoration: InputDecoration(
                errorBorder: border,
                isDense: true,
                isCollapsed: true,
                focusedErrorBorder: border,
                focusedBorder: border,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                disabledBorder: border,
                border: border,
                enabledBorder: border,
                hintText: "New",
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.mainGray),
        borderRadius: BorderRadius.circular(40),
      ),
    );
  }
}

class _TagFormatter extends TextInputFormatter {
  static const int _limit = 50;
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length <= _limit) {
      return newValue;
    }
    return oldValue;
  }
}
