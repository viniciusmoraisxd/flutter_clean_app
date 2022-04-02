import 'package:faker/faker.dart';
import 'package:flutter_clean_app/data/http/http.dart';
import 'package:flutter_clean_app/data/usecases/usecases.dart';
import 'package:flutter_clean_app/domain/entities/entities.dart';
import 'package:flutter_clean_app/domain/helpers/helpers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  String url;
  HttpClientSpy httpClient;
  RemoteLoadSurveyResult sut;
  Map surveyResult;

  PostExpectation mockRequest() => when(
        httpClient.request(
          url: anyNamed('url'),
          method: anyNamed('method'),
        ),
      );

  void mockHttpData(Map data) {
    surveyResult = data;
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  Map mockValidData() => {
        'surveyId': faker.guid.guid(),
        'question': faker.randomGenerator.string(50),
        'answers': [
          {
            'image': faker.internet.httpUrl(),
            'answer': faker.randomGenerator.string(20),
            'percent': faker.randomGenerator.integer(100),
            'counter': faker.randomGenerator.integer(100),
            'isCurrentAccountAnswer': faker.randomGenerator.boolean()
          },
          {
            'answer': faker.randomGenerator.string(20),
            'percent': faker.randomGenerator.integer(100),
            'counter': faker.randomGenerator.integer(100),
            'isCurrentAccountAnswer': faker.randomGenerator.boolean()
          }
        ],
        'date': faker.date.dateTime().toIso8601String(),
      };

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadSurveyResult(url: url, httpClient: httpClient);

    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.loadBySurvey();

    verify(httpClient.request(url: url, method: "get"));
  });

  test('Should return SurveyResult on 200', () async {
    final result = await sut.loadBySurvey();

    expect(
        result,
        SurveyResultEntity(
          surveyId: surveyResult['surveyId'],
          question: surveyResult['question'],
          answers: [
            SurveyAnswerEntity(
              isCurrentAnswer: surveyResult['answers'][0]
                  ['isCurrentAccountAnswer'],
              image: surveyResult['answers'][0]['image'],
              answer: surveyResult['answers'][0]['answer'],
              percent: surveyResult['answers'][0]['percent'],
            ),
            SurveyAnswerEntity(
              isCurrentAnswer: surveyResult['answers'][1]
                  ['isCurrentAccountAnswer'],
              answer: surveyResult['answers'][1]['answer'],
              percent: surveyResult['answers'][1]['percent'],
            ),
          ],
        ));

    verify(httpClient.request(url: url, method: "get"));
  });

  test('Should return an UnexpectedError on success and data is invalid',
      () async {
    mockHttpData({"invalid_key": "invalid_value"});

    final future = sut.loadBySurvey();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw an UnexpectedError if HttpClient returns status code 404',
      () async {
    mockHttpError(HttpError.notFound);

    final future = sut.loadBySurvey();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw an UnexpectedError if HttpClient returns status code 500',
      () async {
    mockHttpError(HttpError.serverError);

    final future = sut.loadBySurvey();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw an AccessDenied if HttpClient returns status code 403',
      () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.loadBySurvey();

    expect(future, throwsA(DomainError.accessDenied));
  });
}
