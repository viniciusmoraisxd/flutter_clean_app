import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';

import 'package:flutter_clean_app/domain/usecases/usecases.dart';

class GetxSurveysPresenter {
  final LoadSurveys loadSurveys;

  GetxSurveysPresenter({@required this.loadSurveys});

  @override
  Future<void> loadData() async {
    await loadSurveys.load();
  }
}

class LoadSurveysSpy extends Mock implements LoadSurveys {}

void main() {
  test('Should call LoadSurveys on loadData', () async {
    final loadSurveysSpy = LoadSurveysSpy();
    final sut = GetxSurveysPresenter(loadSurveys: loadSurveysSpy);

    await sut.loadData();

    verify(loadSurveysSpy.load()).called(1);
  });
}
