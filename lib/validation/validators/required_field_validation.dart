import 'package:equatable/equatable.dart';
import 'package:flutter_clean_app/validation/protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  final String field;
  RequiredFieldValidation(this.field);

  @override
  String validate(String value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatório';
  }

  @override
  List<Object> get props => [field];
}
