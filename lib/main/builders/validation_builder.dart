import 'package:flutter_clean_app/validation/protocols/protocols.dart';
import 'package:flutter_clean_app/validation/validators/validators.dart';

class ValidationBuilder {
  ValidationBuilder._();
  static ValidationBuilder _instance;
  String fieldName;
  List<FieldValidation> validations = [];

  static ValidationBuilder field(String fieldName) {
    _instance = ValidationBuilder._();
    _instance.fieldName = fieldName;

    return _instance;
  }

  ValidationBuilder required() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationBuilder email() {
    validations.add(EmailValidation(fieldName));
    return this;
  }

  ValidationBuilder min(int minLength) {
    validations
        .add(MinLengthValidation(field: fieldName, minLength: minLength));
    return this;
  }

  List<FieldValidation> build() => validations;
}
