import 'package:flutter/cupertino.dart';

class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTap: () => Navigator.pop(context),
      child: Text("Cancel",
          style: TextStyle(color: Color(0xFF5f5f5f), fontSize: 15),
          textAlign: TextAlign.justify),
    );
  }
}
