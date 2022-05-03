import 'package:flutter_clean_app/domain/helpers/helpers.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:flutter_clean_app/presentation/mixins/mixins.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class GetxSurveysPresenter extends GetxController
    with SessionManager, LoadingManager, NavigateManager
    implements SurveysPresenter {
  final LoadSurveys loadSurveys;
  final _surveys = Rx<List<SurveysViewModel>>();

  GetxSurveysPresenter({@required this.loadSurveys});

  Stream<List<SurveysViewModel>> get surveysStream => _surveys.stream;

  Future<void> loadData() async {
    try {
      isLoading = true;
      final surveys = await loadSurveys.load();

      _surveys.value = surveys
          .map(
            (survey) => SurveysViewModel(
                id: survey.id,
                question: survey.question,
                date: DateFormat('dd MMM yyyy').format(survey.date),
                didAnswer: survey.didAnswer),
          )
          .toList();
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        _surveys.subject.addError(UIError.unexpected.description);
      }
    } finally {
      isLoading = false;
    }
  }

  @override
  void goToSurveyResult(String surveyId) {
    navigateTo = '/survey_result/$surveyId';
  }
}
