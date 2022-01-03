import 'package:flutter_clean_app/main/factories/factories.dart';
import 'package:flutter_clean_app/main/factories/pages/login/login.dart';
import 'package:flutter_clean_app/main/factories/usecases/usecases.dart';
import 'package:flutter_clean_app/presentation/presenters/presenters.dart';

GetxLoginPresenter makeGetxLoginPresenter() => GetxLoginPresenter(
    validation: makeValidationComposite(),
    authentication: makeRemoteAuthentication(),
    saveCurrentAccount: makeLocalSaveCurrentAccount());
