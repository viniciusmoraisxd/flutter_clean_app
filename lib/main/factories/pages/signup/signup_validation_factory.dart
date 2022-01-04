import 'package:flutter_clean_app/main/builders/builders.dart';
import 'package:flutter_clean_app/validation/protocols/protocols.dart';
import 'package:flutter_clean_app/validation/validators/validators.dart';

ValidationComposite makeSignupValidation() =>
    ValidationComposite(makeSignupValidations());

List<FieldValidation> makeSignupValidations() {
  return [
    ...ValidationBuilder.field('name').required().min(3).build(),
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().min(3).build(),
    ...ValidationBuilder.field('passwordConfirmation')
        .required()
        .sameAs('password')
        .build(),
  ];
}
