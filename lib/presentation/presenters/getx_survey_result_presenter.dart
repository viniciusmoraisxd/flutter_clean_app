import 'package:flutter_clean_app/domain/helpers/helpers.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class GetxSurveyResultPresenter implements SurveyResultPresenter {
  final LoadSurveyResult loadSurveyResult;
  final String surveyId;

  final _isLoading = true.obs;
  final _surveyResult = Rx<SurveyResultViewModel>();

  GetxSurveyResultPresenter({
    @required this.loadSurveyResult,
    @required this.surveyId,
  });

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<SurveyResultViewModel> get surveyResultStream => _surveyResult.stream;

  Future<void> loadData() async {
    try {
      _isLoading.value = true;
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
    } on DomainError {
      _surveyResult.subject.addError(UIError.unexpected.description);
    } finally {
      _isLoading.value = false;
    }
  }
}
