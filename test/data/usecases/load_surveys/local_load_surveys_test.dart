import 'package:faker/faker.dart';
import 'package:flutter_clean_app/data/cache/cache.dart';
import 'package:flutter_clean_app/data/usecases/usecases.dart';
import 'package:flutter_clean_app/domain/entities/entities.dart';
import 'package:flutter_clean_app/domain/helpers/helpers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class CacheStorageSpy extends Mock implements CacheStorage {}

void main() {
  group('Load', () {
    CacheStorageSpy cacheStorageSpy;
    LocalLoadSurveys sut;
    List<Map> data;
    List<Map> mockValidData() => [
          {
            'id': faker.guid.guid(),
            'question': faker.randomGenerator.string(10),
            'date': '2021-01-24T00:00:00.000Z',
            'didAnswer': 'false',
          },
          {
            'id': faker.guid.guid(),
            'question': faker.randomGenerator.string(10),
            'date': '2022-02-24T00:00:00.000Z',
            'didAnswer': 'true',
          }
        ];

    PostExpectation mockFetchCall() => when(cacheStorageSpy.fetch(any));

    void mockFetch(List<Map> list) {
      data = list;
      mockFetchCall().thenAnswer((_) async => data);
    }

    void mockFetchError() => mockFetchCall().thenThrow(Exception());

    setUp(() {
      cacheStorageSpy = CacheStorageSpy();
      sut = LocalLoadSurveys(cacheStorage: cacheStorageSpy);

      mockFetch(mockValidData());
    });

    test('Should call CacheStorage with correct key', () async {
      await sut.load();

      verify(cacheStorageSpy.fetch('surveys')).called(1);
    });

    test('Should return a list of surveys on success', () async {
      final surveys = await sut.load();

      expect(surveys, [
        SurveyEntity(
            id: data[0]['id'],
            question: data[0]['question'],
            date: DateTime.utc(2021, 1, 24),
            didAnswer: false),
        SurveyEntity(
            id: data[1]['id'],
            question: data[1]['question'],
            date: DateTime.utc(2022, 2, 24),
            didAnswer: true),
      ]);
    });

    test('Should throw UnexpectedError if cache is empty', () async {
      mockFetch([]);

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is null', () async {
      mockFetch(null);

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is invalid', () async {
      mockFetch([
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(10),
          'date': 'invalid date',
          'didAnswer': 'false',
        }
      ]);

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is incomplete', () async {
      mockFetch([
        {
          'date': '2022-02-24T00:00:00.000Z',
          'didAnswer': 'false',
        }
      ]);

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache throws', () async {
      mockFetchError();

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });
  });

  group('Validate', () {
    LocalLoadSurveys sut;
    CacheStorageSpy cacheStorageSpy;
    List<Map> data;
    List<Map> mockValidData() => [
          {
            'id': faker.guid.guid(),
            'question': faker.randomGenerator.string(10),
            'date': '2021-01-24T00:00:00.000Z',
            'didAnswer': 'false',
          },
          {
            'id': faker.guid.guid(),
            'question': faker.randomGenerator.string(10),
            'date': '2022-02-24T00:00:00.000Z',
            'didAnswer': 'true',
          }
        ];

    PostExpectation mockFetchCall() => when(cacheStorageSpy.fetch(any));
    void mockFetchError() => mockFetchCall().thenThrow(Exception());

    void mockFetch(List<Map> list) {
      data = list;
      mockFetchCall().thenAnswer((_) async => data);
    }

    setUp(() {
      cacheStorageSpy = CacheStorageSpy();
      sut = LocalLoadSurveys(cacheStorage: cacheStorageSpy);

      mockFetch(mockValidData());
    });

    test('Should delete cache if data is invalid', () async {
      mockFetch([
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(10),
          'date': 'invalid date',
          'didAnswer': 'false',
        },
      ]);

      await sut.validate();

      verify(cacheStorageSpy.delete('surveys')).called(1);
    });

    test('Should delete cache if data is incomplete', () async {
      mockFetch([
        {
          'date': '2021-01-24T00:00:00.000Z',
          'didAnswer': 'false',
        },
      ]);

      await sut.validate();

      verify(cacheStorageSpy.delete('surveys')).called(1);
    });

    test('Should delete cache if data is incomplete', () async {
      mockFetchError();

      await sut.validate();

      verify(cacheStorageSpy.delete('surveys')).called(1);
    });
  });

  group('Save', () {
    LocalLoadSurveys sut;
    CacheStorageSpy cacheStorageSpy;
    List<SurveyEntity> surveys;
    List<SurveyEntity> mockSurveys() => [
          SurveyEntity(
            id: faker.guid.guid(),
            question: faker.randomGenerator.string(10),
            date: DateTime.utc(2022, 2, 2),
            didAnswer: true,
          ),
          SurveyEntity(
            id: faker.guid.guid(),
            question: faker.randomGenerator.string(10),
            date: DateTime.utc(2021, 1, 1),
            didAnswer: false,
          )
        ];

    PostExpectation mockSaveCall() => when(
        cacheStorageSpy.save(key: anyNamed('key'), value: anyNamed('value')));

    void mockSaveError() => mockSaveCall().thenThrow(Exception());

    setUp(() {
      cacheStorageSpy = CacheStorageSpy();
      sut = LocalLoadSurveys(cacheStorage: cacheStorageSpy);
      surveys = mockSurveys();
    });

    test('Should call cacheStorage with correct values', () async {
      final list = [
        {
          'id': surveys[0].id,
          'question': surveys[0].question,
          'date': '2022-02-02T00:00:00.000Z',
          'didAnswer': 'true',
        },
        {
          'id': surveys[1].id,
          'question': surveys[1].question,
          'date': '2021-01-01T00:00:00.000Z',
          'didAnswer': 'false',
        }
      ];
      await sut.save(surveys);

      verify(cacheStorageSpy.save(key: 'surveys', value: list)).called(1);
    });

    test('Should throw UnexpectedError if CacheStorage.save fails', () async {
      mockSaveError();

      final future = sut.save(surveys);

      expect(future, throwsA(DomainError.unexpected));
    });
  });
}
