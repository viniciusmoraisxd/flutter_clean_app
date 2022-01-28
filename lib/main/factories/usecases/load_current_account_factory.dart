import 'package:flutter_clean_app/data/usecases/load_current_account/load_current_account.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:flutter_clean_app/main/factories/cache/cache.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() =>
    LocalLoadCurrentAccount(fetchSecureCacheStorage: makeSecureStorageAdapter());
