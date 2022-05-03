import 'package:faker/faker.dart';
import 'package:flutter_clean_app/domain/helpers/helpers.dart';
import 'package:flutter_clean_app/presentation/presenters/presenters.dart';
import 'package:flutter_clean_app/ui/helpers/errors/errors.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_app/domain/entities/entities.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';

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

  PostExpectation mockLoadSurveysCall() => when(loadSurveysSpy.load());

  void mockLoadSurveys(List<SurveyEntity> data) {
    surveys = data;
    mockLoadSurveysCall().thenAnswer((_) async => surveys);
  }

  void mockLoadSurveysError() =>
      mockLoadSurveysCall().thenThrow(DomainError.unexpected);

  void mockAccessDeniedError() =>
      mockLoadSurveysCall().thenThrow(DomainError.accessDenied);

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

  test('Should emit correct events on failure', () async {
    mockLoadSurveysError();
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.surveysStream.listen(
      null,
      onError: expectAsync1(
        (error) => expect(error, UIError.unexpected.description),
      ),
    );

    await sut.loadData();
  });

  test('Should emit correct events on access denied', () async {
    mockAccessDeniedError();
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.isSessionExpiredStream, emits(true));

    await sut.loadData();
  });
  
  test('Should go to SurveyResultPage on survey click', () async {
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/survey_result/1')));

    sut.goToSurveyResult("1");
  });
}
