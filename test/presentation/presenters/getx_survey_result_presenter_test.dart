import 'package:faker/faker.dart';
import 'package:flutter_clean_app/domain/helpers/helpers.dart';
import 'package:flutter_clean_app/presentation/presenters/presenters.dart';
import 'package:flutter_clean_app/ui/helpers/errors/errors.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_app/domain/entities/entities.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';

class LoadSurveyResultSpy extends Mock implements LoadSurveyResult {}

void main() {
  LoadSurveyResultSpy loadSurveyResultSpy;
  GetxSurveyResultPresenter sut;
  SurveyResultEntity surveyResultEntity;
  String surveyId;

  SurveyResultEntity mockValidData() => SurveyResultEntity(
          surveyId: faker.guid.guid(),
          question: faker.lorem.sentence(),
          answers: [
            SurveyAnswerEntity(
                image: faker.internet.httpUrl(),
                isCurrentAnswer: faker.randomGenerator.boolean(),
                answer: faker.lorem.sentence(),
                percent: faker.randomGenerator.integer(100)),
            SurveyAnswerEntity(
                isCurrentAnswer: faker.randomGenerator.boolean(),
                answer: faker.lorem.sentence(),
                percent: faker.randomGenerator.integer(100)),
          ]);

  PostExpectation mockLoadSurveyResultCall() =>
      when(loadSurveyResultSpy.loadBySurvey(surveyId: anyNamed("surveyId")));

  void mockLoadSurveyResult(SurveyResultEntity data) {
    surveyResultEntity = data;
    mockLoadSurveyResultCall().thenAnswer((_) async => surveyResultEntity);
  }

  void mockLoadSurveyResultError() =>
      mockLoadSurveyResultCall().thenThrow(DomainError.unexpected);

  void mockAccessDeniedError() =>
      mockLoadSurveyResultCall().thenThrow(DomainError.accessDenied);
      
  setUp(() {
    surveyId = faker.guid.guid();
    loadSurveyResultSpy = LoadSurveyResultSpy();
    sut = GetxSurveyResultPresenter(
        loadSurveyResult: loadSurveyResultSpy, surveyId: surveyId);
    mockLoadSurveyResult(mockValidData());
  });

  test('Should call Result on loadData', () async {
    await sut.loadData();

    verify(loadSurveyResultSpy.loadBySurvey(surveyId: surveyId)).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.surveyResultStream.listen(
      expectAsync1(
        (result) => expect(
            result,
            SurveyResultViewModel(
                surveyId: surveyResultEntity.surveyId,
                question: surveyResultEntity.question,
                answers: [
                  SurveyAnswerViewModel(
                    image: surveyResultEntity.answers[0].image,
                    isCurrentAnswer:
                        surveyResultEntity.answers[0].isCurrentAnswer,
                    answer: surveyResultEntity.answers[0].answer,
                    percent: "${surveyResultEntity.answers[0].percent}",
                  ),
                  SurveyAnswerViewModel(
                    isCurrentAnswer:
                        surveyResultEntity.answers[1].isCurrentAnswer,
                    answer: surveyResultEntity.answers[1].answer,
                    percent: "${surveyResultEntity.answers[1].percent}",
                  )
                ])),
      ),
    );

    await sut.loadData();
  });

  test('Should emit correct events on failure', () async {
    mockLoadSurveyResultError();

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.surveyResultStream.listen(
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
}
