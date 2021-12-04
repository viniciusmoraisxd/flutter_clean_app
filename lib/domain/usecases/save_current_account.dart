import 'package:flutter_clean_app/domain/entities/entities.dart';

abstract class SaveCurrentAccount {
  Future<void> save(AccountEntity account);
}
