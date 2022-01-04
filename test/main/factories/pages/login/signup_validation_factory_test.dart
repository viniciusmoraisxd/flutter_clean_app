import 'package:flutter_clean_app/main/factories/factories.dart';
import 'package:flutter_clean_app/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeSignupValidations();

    expect(validations, [
      RequiredFieldValidation('name'),
      MinLengthValidation(field: 'name', minLength: 3),
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
      MinLengthValidation(field: 'password', minLength: 3),
      RequiredFieldValidation('passwordConfirmation'),
      CompareFieldsValidation(
          field: 'passwordConfirmation', fieldToCompare: 'password')
    ]);
  });
}
