import 'package:faker/faker.dart';
import 'package:flutter_clean_app/infra/cache/cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mockito/mockito.dart';

class LocalStorageSpy extends Mock implements LocalStorage {}

void main() {
  LocalStorageSpy localStorageSpy;
  LocalStorageAdapter sut;
  String key;
  dynamic value;

  void mockDeleteError() =>
      when(localStorageSpy.deleteItem(any)).thenThrow(Exception());

  void mockSaveError() =>
      when(localStorageSpy.setItem(any, any)).thenThrow(Exception());

  setUp(() {
    localStorageSpy = LocalStorageSpy();
    sut = LocalStorageAdapter(localStorage: localStorageSpy);
    key = faker.randomGenerator.string(5);
    value = faker.randomGenerator.string(50);
  });

  group("Save", () {
    test('Should call localStorage with correct values', () async {
      await sut.save(key: key, value: value);

      verify(localStorageSpy.deleteItem(key)).called(1);
      verify(localStorageSpy.setItem(key, value)).called(1);
    });

    test('Should throw if DeleteItem fails', () async {
      mockDeleteError();
      final future = sut.save(key: key, value: value);

      expect(future, throwsA(isA<Exception>()));
    });

    test('Should throw if SaveItem fails', () async {
      mockSaveError();
      final future = sut.save(key: key, value: value);

      expect(future, throwsA(isA<Exception>()));
    });
  });

  group("Delete", () {
    test('Should call localStorage.delete with correct values', () async {
      await sut.delete(key);

      verify(localStorageSpy.deleteItem(key)).called(1);
    });

    test('Should throw if LocalStorageAdapter.delete fails', () async {
      mockDeleteError();
      final future = sut.delete(key);

      expect(future, throwsA(isA<Exception>()));
    });
  });

  group("Fetch", () {
    String result;

    PostExpectation mockFetchCall() => when(localStorageSpy.getItem(any));

    void mockFetch() {
      result = faker.randomGenerator.string(50);
      mockFetchCall().thenAnswer((_) => result);
    }

    void mockFetchError() => mockFetchCall().thenThrow(Exception());

    setUp(() {
      mockFetch();
    });

    test('Should call localStorage.fetch with correct value', () async {
      await sut.fetch(key);

      verify(localStorageSpy.getItem(key)).called(1);
    });

    test('Should return same value as localStorage', () async {
      final data = await sut.fetch(key);

      expect(data, result);
    });

    test('Should throw if LocalStorageAdapter.fetch fails', () async {
      mockFetchError();
      final future = sut.fetch(key);

      expect(future, throwsA(isA<Exception>()));
    });
  });
}
