import 'package:flutter_clean_app/main/builders/builders.dart';
import 'package:flutter_clean_app/validation/protocols/protocols.dart';
import 'package:flutter_clean_app/validation/validators/validators.dart';

ValidationComposite makeValidationComposite() =>
    ValidationComposite(makeLoginValidations());

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().min(3).build(),
  ];
}
