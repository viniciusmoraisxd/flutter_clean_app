import 'package:flutter_clean_app/data/usecases/usecases.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:flutter_clean_app/main/factories/factories.dart';

LoadSurveyResult makeRemoteLoadSurveyResult(String surveyId) =>
    RemoteLoadSurveyResult(
        httpClient: makeAuthorizeHttpClientDecorator(),
        url: makeApiUrl('surveys/$surveyId/results'));
