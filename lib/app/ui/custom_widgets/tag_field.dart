import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';

class TagField extends StatelessWidget implements Widget {
  final String tag;
  final bool _isTemporary;
  final void Function() action;
  String displayTag() {
    return tag.length > 26 ? tag.substring(0, 23) + "..." : tag;
  }

  const TagField(this.tag)
      : _isTemporary = false,
        action = null;

  const TagField.temporary({this.tag, this.action}) : _isTemporary = true;

  @override
  Widget build(BuildContext context) {
    if (_isTemporary)
      return Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
        child: Container(
          height: 25,
          padding: const EdgeInsets.only(left: 10, right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                displayTag(),
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              GestureDetector(
                onTap: action,
                excludeFromSemantics: true,
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 15,
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: AppColors.underLineColor,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      );
    else {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
        child: Container(
          height: 25,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          child: Text(
            displayTag(),
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
          decoration: BoxDecoration(
            color: AppColors.underLineColor,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      );
    }
  }
}
