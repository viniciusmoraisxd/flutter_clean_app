import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/helpers/errors/ui_error.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:flutter_clean_app/ui/pages/login/login_presenter.dart';
import 'package:provider/provider.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<UIError>(
        stream: presenter.emailErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
                labelText: R.strings.email,
                icon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColorLight,
                ),
                errorText: snapshot.hasData ? snapshot.data.description : null),
            keyboardType: TextInputType.emailAddress,
            onChanged: presenter.validateEmail,
          );
        });
  }
}
