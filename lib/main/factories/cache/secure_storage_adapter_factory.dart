import 'package:flutter_clean_app/infra/cache/cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

SecureStorageAdapter makeSecureStorageAdapter() =>
    SecureStorageAdapter(secureStorage: FlutterSecureStorage());
