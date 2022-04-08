import '../pages.dart';

abstract class SurveyResultPresenter {
  Stream<bool> get isLoadingStream;
  Stream<SurveyResultViewModel> get surveyResultStream;

  Future<void> loadData();
}
