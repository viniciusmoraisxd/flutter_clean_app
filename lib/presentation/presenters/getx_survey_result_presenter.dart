import 'package:flutter_clean_app/domain/helpers/helpers.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:flutter_clean_app/presentation/mixins/mixins.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class GetxSurveyResultPresenter extends GetxController
    with LoadingManager, SessionManager
    implements SurveyResultPresenter {
  final LoadSurveyResult loadSurveyResult;
  final String surveyId;

  final _surveyResult = Rx<SurveyResultViewModel>();

  GetxSurveyResultPresenter({
    @required this.loadSurveyResult,
    @required this.surveyId,
  });

  Stream<SurveyResultViewModel> get surveyResultStream => _surveyResult.stream;

  Future<void> loadData() async {
    try {
      isLoading = true;
      final surveyResult =
          await loadSurveyResult.loadBySurvey(surveyId: surveyId);

      _surveyResult.value = SurveyResultViewModel(
          surveyId: surveyResult.surveyId,
          question: surveyResult.question,
          answers: surveyResult.answers
              .map(
                (e) => SurveyAnswerViewModel(
                  image: e.image,
                  isCurrentAnswer: e.isCurrentAnswer,
                  answer: e.answer,
                  percent: "${e.percent}",
                ),
              )
              .toList());
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        _surveyResult.subject.addError(UIError.unexpected.description);
      }
    } finally {
      isLoading = false;
    }
  }
}
