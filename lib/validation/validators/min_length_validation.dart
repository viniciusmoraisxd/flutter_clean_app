import 'package:equatable/equatable.dart';
import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/validation/protocols/protocols.dart';
import 'package:meta/meta.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  final String field;
  final int minLength;

  MinLengthValidation({@required this.field, @required this.minLength});

  @override
  ValidationError validate(Map input) {
    return input[field] != null && input[field].length >= minLength
        ? null
        : ValidationError.invalidField;
  }

  @override
  List<Object> get props => [field, minLength];
}
