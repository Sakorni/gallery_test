import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showErrorSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
}
