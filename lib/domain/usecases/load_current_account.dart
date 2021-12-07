import 'package:flutter_clean_app/domain/entities/entities.dart';

abstract class LoadCurrentAccount {
  Future<AccountEntity> load();
}
