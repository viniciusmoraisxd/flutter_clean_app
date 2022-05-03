import 'package:faker/faker.dart';
import 'package:flutter_clean_app/infra/cache/cache.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  FlutterSecureStorageSpy secureStorage;
  SecureStorageAdapter sut;
  String key;
  String value;

  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = SecureStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  group('Save Secure', () {
    void mockSaveSecureError() => when(
            secureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());

    test('Should call save secure with correct values', () async {
      await sut.save(key: key, value: value);

      verify(secureStorage.write(key: key, value: value));
    });
    test('Should throws if save secure throws', () async {
      mockSaveSecureError();

      final future = sut.save(key: key, value: value);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('Fetch Secure', () {
    void mockFetchSecure() {
      when(secureStorage.read(key: anyNamed('key')))
          .thenAnswer((_) async => value);
    }

    setUp(() {
      mockFetchSecure();
    });

    test('Should call fetch with correct values', () async {
      await sut.fetch(key);

      verify(secureStorage.read(key: key));
    });

    test('Should return correct value on success', () async {
      final fetchedValue = await sut.fetch(key);

      expect(fetchedValue, value);
    });

    test('Should throws if fetch throws', () async {
      when(secureStorage.read(key: anyNamed('key'))).thenThrow(Exception());

      final future = sut.fetch(key);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group("Delete", () {
    void mockDeleteSecureError() =>
        when(secureStorage.delete(key: anyNamed('key'))).thenThrow(Exception());
    test('Should call delete with correct key', () async {
      await sut.delete(key);

      verify(secureStorage.delete(key: key)).called(1);
    });

    test('Should throw if delete fails', () async {
      mockDeleteSecureError();
      final future = sut.delete(key);

      expect(future, throwsA(isA<Exception>()));
    });
  });
}
