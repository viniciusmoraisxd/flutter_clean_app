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
    test('Should call save secure with correct values', () async {
      await sut.saveSecure(key: key, value: value);

      verify(secureStorage.write(key: key, value: value));
    });
    test('Should throws if save secure throws', () async {
      when(sut.saveSecure(key: anyNamed('key'), value: anyNamed('value')))
          .thenThrow(Exception());

      final future = sut.saveSecure(key: key, value: value);

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

    test('Should call fetchSecure with correct values', () async {
      await sut.fetchSecure(key);

      verify(secureStorage.read(key: key));
    });

    test('Should return correct value on success', () async {
      final fetchedValue = await sut.fetchSecure(key);

      expect(fetchedValue, value);
    });

    test('Should throws if fetchSecure throws', () async {
      when(secureStorage.read(key: anyNamed('key'))).thenThrow(Exception());

      final future = sut.fetchSecure(key);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });
}
