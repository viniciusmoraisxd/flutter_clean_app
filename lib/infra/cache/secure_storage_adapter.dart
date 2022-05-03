import 'package:flutter_clean_app/data/cache/cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

class SecureStorageAdapter
    implements
        SaveSecureCacheStorage,
        FetchSecureCacheStorage,
        DeleteSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  SecureStorageAdapter({@required this.secureStorage});

  @override
  Future<void> save(
      {@required String key, @required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String> fetch(String key) async {
    return await secureStorage.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    await secureStorage.delete(key: key);
  }
}
