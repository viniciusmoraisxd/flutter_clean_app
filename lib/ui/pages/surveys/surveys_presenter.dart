import 'surveys_view_model.dart';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<SurveysViewModel>> get loadSurveysStream;

  Future<void> loadData();
}
