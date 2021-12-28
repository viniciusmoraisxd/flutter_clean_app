import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:provider/provider.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignupPresenter>(context);
    return StreamBuilder<UIError>(
        stream: presenter.emailErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: R.strings.email,
                icon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColorLight,
                ),
                errorText: snapshot.hasData ? snapshot.data.description : null),
            onChanged: presenter.validateEmail,
          );
        });
  }
}
