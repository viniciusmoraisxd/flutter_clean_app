import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/validation/protocols/protocols.dart';
import 'package:meta/meta.dart';

class CompareFieldsValidation implements FieldValidation {
  final String field;
  final String valueToCompare;

  CompareFieldsValidation(
      {@required this.field, @required this.valueToCompare});

  @override
  ValidationError validate(String value) {
    return value == valueToCompare ? null : ValidationError.invalidField;
  }
}
