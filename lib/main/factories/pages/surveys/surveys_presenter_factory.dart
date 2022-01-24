import 'package:flutter_clean_app/presentation/presenters/presenters.dart';

import '../../factories.dart';

GetxSurveysPresenter makeGetxSurveysPresenter() =>
    GetxSurveysPresenter(loadSurveys: makeRemoteLoadSurveys());
