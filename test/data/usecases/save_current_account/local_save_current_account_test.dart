import 'package:faker/faker.dart';
import 'package:flutter_clean_app/data/cache/cache.dart';
import 'package:flutter_clean_app/data/usecases/usecases.dart';
import 'package:flutter_clean_app/domain/entities/account_entity.dart';
import 'package:flutter_clean_app/domain/helpers/helpers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  LocalSaveCurrentAccount sut;
  AccountEntity account;
  SaveSecureCacheStorageSpy saveSecureCacheStorage;

  setUp(() {
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(account);

    verify(
        saveSecureCacheStorage.save(key: 'token', value: account.token));
  });

  test('Should throws Unexpected if SaveSecureCacheStorage Throws', () async {
    when(
      saveSecureCacheStorage.save(
        key: anyNamed('key'),
        value: anyNamed('value'),
      ),
    ).thenThrow(Exception());

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
