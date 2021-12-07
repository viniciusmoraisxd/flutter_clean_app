import 'package:flutter_clean_app/infra/cache/local_storage_adapter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

LocalStorageAdapter makeLocalStorageAdapter() =>
    LocalStorageAdapter(secureStorage: FlutterSecureStorage());
