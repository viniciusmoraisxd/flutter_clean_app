import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:provider/provider.dart';

class PasswordConfirmationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignupPresenter>(context);
    return StreamBuilder<UIError>(
        stream: presenter.passwordConfirmationErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: R.strings.confirmPassword,
              icon: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColorLight,
              ),
              errorText: snapshot.hasData ? snapshot.data.description : null,
            ),
            onChanged: presenter.validatePasswordConfirmation,
          );
        });
  }
}
