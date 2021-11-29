import 'package:flutter_clean_app/main/factories/factories.dart';
import 'package:flutter_clean_app/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password')
    ]);
  });
}
