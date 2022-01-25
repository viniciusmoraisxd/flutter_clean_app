import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';

class LocalLoadSurveys {
  final FetchCacheStorage fetchCacheStorage;

  LocalLoadSurveys({@required this.fetchCacheStorage});
  
  Future<void> load() async {
    await fetchCacheStorage.fetch('surveys');
  }
}

abstract class FetchCacheStorage {
  Future<void> fetch(String key);
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {}

void main() {
  test('Should calll FetchCacheStorage with correct key', () async {
    final fetchCacheStorageSpy = FetchCacheStorageSpy();
    final sut = LocalLoadSurveys(fetchCacheStorage: fetchCacheStorageSpy);

    await sut.load();

    verify(fetchCacheStorageSpy.fetch('surveys')).called(1);
  });
}
