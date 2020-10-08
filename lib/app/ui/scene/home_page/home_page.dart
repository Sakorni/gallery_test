import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  final String id;

  const HomePage({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Flexible(
            child: Text(
          id,
          style: TextStyle(fontSize: 20, color: Colors.green),
        )),
      ),
    );
  }
}
