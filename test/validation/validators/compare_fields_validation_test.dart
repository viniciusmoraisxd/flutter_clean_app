import 'package:flutter_clean_app/presentation/protocols/validation.dart';
import 'package:flutter_clean_app/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  CompareFieldsValidation sut;

  setUp(() {
    sut = CompareFieldsValidation(
        field: 'any_field', valueToCompare: 'any_value');
  });

  test('Should return an error if value is different than valueToCompare', () {
    expect(sut.validate('different_value'), ValidationError.invalidField);
  });

  test('Should return null if value is equal than valueToCompare', () {
    expect(sut.validate('any_value'), null);
  });
}
