import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/components/components.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:provider/provider.dart';
import '../../mixins/mixins.dart';

import 'components/components.dart';
import 'signup_presenter.dart';

class SignupPage extends StatelessWidget
    with KeyboardManager, LoadingManager, UIErrorManager, NavigateManager {
  final SignupPresenter presenter;

  const SignupPage(this.presenter);

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
                    R.strings.addAccount,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Provider(
                      create: (_) => presenter,
                      child: Form(
                        child: Column(
                          children: [
                            NameInput(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: EmailInput(),
                            ),
                            PasswordInput(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 32.0),
                              child: PasswordConfirmationInput(),
                            ),
                            SignupButton(),
                            FlatButton.icon(
                              onPressed: presenter.goToLogin,
                              icon: Icon(Icons.exit_to_app),
                              label: Text(R.strings.login),
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
