import 'package:flutter_clean_app/presentation/presenters/presenters.dart';
import 'package:get/get.dart';

import '../../factories.dart';

GetxSurveyResultPresenter makeGetxSurveyResultPresenter(String surveyId) =>
    GetxSurveyResultPresenter(
        loadSurveyResult: makeRemoteLoadSurveyResult(surveyId),
        surveyId: surveyId);
