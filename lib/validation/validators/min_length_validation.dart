import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/validation/protocols/protocols.dart';
import 'package:meta/meta.dart';

class MinLengthValidation implements FieldValidation {
  final String field;
  final int minLength;

  MinLengthValidation({@required this.field, @required this.minLength});

  @override
  ValidationError validate(String value) {
    return value != null && value.length >= minLength
        ? null
        : ValidationError.invalidField;
  }
}
