import 'package:flutter/material.dart';

import 'package:flutter_clean_app/ui/components/components.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:provider/provider.dart';

import 'components/components.dart';
import '../../mixins/mixins.dart';

class LoginPage extends StatelessWidget
    with KeyboardManager, LoadingManager, UIErrorManager, NavigateManager {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          handleLoading(context: context, stream: presenter.isLoadingStream);
          handleError(context: context, stream: presenter.mainErrorStream);
          handleNavigation(
              context: context, stream: presenter.navigateToStream);

          return GestureDetector(
            onTap: () => hideKeyboard(context),
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
                              onPressed: presenter.goToSignup,
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
