import 'package:faker/faker.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';

import 'package:flutter_clean_app/domain/entities/entities.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';

class GetxSurveysPresenter {
  final LoadSurveys loadSurveys;
  final _isLoading = true.obs;
  final _surveys = Rx<List<SurveysViewModel>>();

  GetxSurveysPresenter({@required this.loadSurveys});

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<List<SurveysViewModel>> get surveysStream => _surveys.stream;

  Future<void> loadData() async {
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
    _isLoading.value = false;
  }
}

class LoadSurveysSpy extends Mock implements LoadSurveys {}

void main() {
  LoadSurveysSpy loadSurveysSpy;
  GetxSurveysPresenter sut;
  List<SurveyEntity> surveys;

  List<SurveyEntity> mockValidData() => [
        SurveyEntity(
            id: faker.guid.guid(),
            question: faker.lorem.sentence(),
            date: DateTime(2022, 01, 23),
            didAnswer: true),
        SurveyEntity(
            id: faker.guid.guid(),
            question: faker.lorem.sentence(),
            date: DateTime(2018, 10, 03),
            didAnswer: false),
      ];

  void mockLoadSurveys(List<SurveyEntity> data) {
    surveys = data;
    when(loadSurveysSpy.load()).thenAnswer((_) async => surveys);
  }

  setUp(() {
    loadSurveysSpy = LoadSurveysSpy();
    sut = GetxSurveysPresenter(loadSurveys: loadSurveysSpy);
    mockLoadSurveys(mockValidData());
  });

  test('Should call LoadSurveys on loadData', () async {
    await sut.loadData();

    verify(loadSurveysSpy.load()).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.surveysStream.listen(
      expectAsync1(
        (surveys) => expect(surveys, [
          SurveysViewModel(
              id: surveys[0].id,
              question: surveys[0].question,
              date: '23 Jan 2022',
              didAnswer: surveys[0].didAnswer),
          SurveysViewModel(
              id: surveys[1].id,
              question: surveys[1].question,
              date: '03 Oct 2018',
              didAnswer: surveys[1].didAnswer),
        ]),
      ),
    );

    await sut.loadData();
  });
}
