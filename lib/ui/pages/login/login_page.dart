import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/components/components.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            Text(
              'Login',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Form(
                child: Column(
                  children: [
                    StreamBuilder<String>(
                        stream: presenter.emailErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            decoration: InputDecoration(
                                labelText: 'E-mail',
                                icon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                errorText: snapshot.data),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: presenter.validateEmail,
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          icon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                        obscureText: true,
                        onChanged: presenter.validatePassword,
                      ),
                    ),
                    RaisedButton(
                      onPressed: null,
                      child: Text('Logar'),
                    ),
                    FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.person),
                      label: Text('Criar Conta'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
