import 'package:flutter_clean_app/validation/protocols/protocols.dart';
import 'package:flutter_clean_app/validation/validators/required_field_validation.dart';
import 'package:flutter_clean_app/validation/validators/validation_composite.dart';
import 'package:flutter_clean_app/validation/validators/validators.dart';

ValidationComposite makeValidationComposite() =>
    ValidationComposite(makeLoginValidations());

List<FieldValidation> makeLoginValidations() {
  return [
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password')
  ];
}
