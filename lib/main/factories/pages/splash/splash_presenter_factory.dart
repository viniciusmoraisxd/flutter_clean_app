import 'package:flutter_clean_app/main/factories/factories.dart';

import 'package:flutter_clean_app/presentation/presenters/presenters.dart';

GetxSplashPresenter makeGetxSplashPresenter() =>
    GetxSplashPresenter(loadCurrentAccount: makeLocalLoadCurrentAccount());
