import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_clean_app/domain/entities/account_entity.dart';

abstract class AddAccount {
  Future<AccountEntity> add(AddAccountParams params);
}

class AddAccountParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  AddAccountParams(
      {@required this.name,
      @required this.email,
      @required this.password,
      @required this.passwordConfirmation});

  @override
  List get props => [name, email, password, passwordConfirmation];
}
