import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';

class EmptyTagField extends StatelessWidget {
  final TextEditingController _controller;

  const EmptyTagField(this._controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 25,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        child: TextFormField(
          style: TextStyle(fontSize: 12, color: Colors.white),
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide()),
              hintText: "New",
              prefix: Icon(
                Icons.add,
                color: AppColors.mainGray,
              )),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
