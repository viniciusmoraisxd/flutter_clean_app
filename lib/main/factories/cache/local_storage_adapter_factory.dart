import 'package:flutter_clean_app/infra/cache/cache.dart';
import 'package:localstorage/localstorage.dart';

LocalStorageAdapter makeLocalStorageAdapter() =>
    LocalStorageAdapter(localStorage: LocalStorage('fordev'));
