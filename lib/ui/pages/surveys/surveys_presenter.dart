import 'surveys_view_model.dart';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<SurveysViewModel>> get surveysStream;
  void goToSurveyResult(String surveyId);
  Stream<String> get navigateToStream;

  Future<void> loadData();
}
