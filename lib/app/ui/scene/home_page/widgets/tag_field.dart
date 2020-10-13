import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';

class TagField extends StatelessWidget {
  final String tag;
  String displayTag() {
    return tag.length > 26 ? tag.substring(0, 23) + "..." : tag;
  }

  const TagField(this.tag);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 25,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        child: Text(
          displayTag(),
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: AppColors.underLineColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
