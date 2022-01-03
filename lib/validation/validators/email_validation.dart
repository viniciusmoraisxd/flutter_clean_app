import 'package:equatable/equatable.dart';
import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/validation/protocols/protocols.dart';

class EmailValidation extends Equatable implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  @override
  ValidationError validate(Map input) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = input[field]?.isNotEmpty != true || regex.hasMatch(input[field]);
    return isValid ? null : ValidationError.invalidField;
  }

  @override
  List<Object> get props => [field];
}
