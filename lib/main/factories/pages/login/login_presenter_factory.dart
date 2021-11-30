import 'package:flutter_clean_app/main/factories/factories.dart';
import 'package:flutter_clean_app/main/factories/pages/login/login.dart';
import 'package:flutter_clean_app/presentation/presenters/presenters.dart';

StreamLoginPresenter makeStreamLoginPresenter() => StreamLoginPresenter(
    validation: makeValidationComposite(),
    authentication: makeRemoteAuthentication());

GetxLoginPresenter makeGetxLoginPresenter() => GetxLoginPresenter(
    validation: makeValidationComposite(),
    authentication: makeRemoteAuthentication());
