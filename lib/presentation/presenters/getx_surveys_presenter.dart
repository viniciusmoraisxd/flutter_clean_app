import 'package:flutter_clean_app/domain/helpers/helpers.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class GetxSurveysPresenter implements SurveysPresenter {
  final LoadSurveys loadSurveys;
  final _isLoading = true.obs;
  final _surveys = Rx<List<SurveysViewModel>>();

  GetxSurveysPresenter({@required this.loadSurveys});

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<List<SurveysViewModel>> get surveysStream => _surveys.stream;

  Future<void> loadData() async {
    try {
      _isLoading.value = true;
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
    } on DomainError {
      _surveys.subject.addError(UIError.unexpected.description);
    } finally {
      _isLoading.value = false;
    }
  }
}
