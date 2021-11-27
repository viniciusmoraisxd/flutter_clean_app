import 'package:flutter_clean_app/main/factories/factories.dart';
import 'package:flutter_clean_app/main/factories/pages/login/login_validation_factory.dart';
import 'package:flutter_clean_app/presentation/presenters/presenters.dart';

StreamLoginPresenter makeLoginPresenter() => StreamLoginPresenter(
    validation: makeValidationComposite(),
    authentication: makeRemoteAuthentication());
