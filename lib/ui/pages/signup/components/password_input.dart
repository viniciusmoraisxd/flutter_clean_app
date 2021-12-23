import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: R.strings.password,
        icon: Icon(
          Icons.lock,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    );
  }
}
