import 'package:faker/faker.dart';
import 'package:flutter_clean_app/domain/entities/account_entity.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({@required this.fetchSecureCacheStorage});

  Future<AccountEntity> load() async {
    final token = await fetchSecureCacheStorage.fetchSecure('token');

    return AccountEntity(token);
  }
}

abstract class FetchSecureCacheStorage {
  Future<String> fetchSecure(String key);
}

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  LocalLoadCurrentAccount sut;
  String token;

  void mockFetchSecure() {
    when(fetchSecureCacheStorage.fetchSecure(any))
        .thenAnswer((_) async => token);
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(
        fetchSecureCacheStorage: fetchSecureCacheStorage);
    token = faker.guid.guid();
    mockFetchSecure();
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();
    verify(fetchSecureCacheStorage.fetchSecure('token'));
  });

  test('Should return an accountEntity', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token));
  });
}
