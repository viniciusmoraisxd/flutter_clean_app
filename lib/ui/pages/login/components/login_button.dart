import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/pages/login/login_presenter.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<bool>(
        stream: presenter.isFormValidStream,
        builder: (context, snapshot) {
          return RaisedButton(
            onPressed: snapshot.data == true ? presenter.auth : null,
            child: Text('Logar'),
          );
        });
  }
}
