import 'package:flutter_clean_app/main/factories/factories.dart';
import 'package:flutter_clean_app/main/factories/usecases/usecases.dart';
import 'package:flutter_clean_app/presentation/presenters/presenters.dart';

GetxSignupPresenter makeGetxSignupPresenter() => GetxSignupPresenter(
    validation: makeSignupValidation(),
    saveCurrentAccount: makeLocalSaveCurrentAccount(),
    addAccount: makeRemoteAddAccount());
