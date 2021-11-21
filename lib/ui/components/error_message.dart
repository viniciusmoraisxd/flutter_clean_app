import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String error) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(error),
    backgroundColor: Colors.red[900],
  ));
}
