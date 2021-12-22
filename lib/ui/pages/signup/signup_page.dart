import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/components/components.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';

import 'package:provider/provider.dart';

import 'components/components.dart';
import 'signup_presenter.dart';

class SignupPage extends StatelessWidget {
  final SignupPresenter presenter;

  const SignupPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return GestureDetector(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHeader(),
                  Text(
                    R.strings.login,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Provider(
                      create: (context) => presenter,
                      child: Form(
                        child: Column(
                          children: [
                            EmailInput(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 32.0),
                              child: PasswordInput(),
                            ),
                            LoginButton(),
                            FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.person),
                              label: Text(R.strings.addAccount),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
