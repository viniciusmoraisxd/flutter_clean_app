import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/validation/protocols/protocols.dart';
import 'package:meta/meta.dart';

class CompareFieldsValidation implements FieldValidation {
  final String field;
  final String fieldToCompare;

  CompareFieldsValidation(
      {@required this.field, @required this.fieldToCompare});

  @override
  ValidationError validate(Map input) {
    return input[field] == input[fieldToCompare] ? null : ValidationError.invalidField;
  }
}
