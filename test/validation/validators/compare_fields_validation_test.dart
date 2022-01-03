import 'package:flutter_clean_app/presentation/protocols/validation.dart';
import 'package:flutter_clean_app/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  CompareFieldsValidation sut;

  setUp(() {
    sut = CompareFieldsValidation(
        field: 'any_field', fieldToCompare: 'other_field');
  });

  test('Should return an error if value is different than valueToCompare', () {
    final formData = {
      'any_field': 'any_value',
      'other_field': 'other_value',
    };
    expect(sut.validate(formData), ValidationError.invalidField);
  });

  test('Should return null if value is equal than valueToCompare', () {
       final formData = {
      'any_field': 'any_value',
      'other_field': 'any_value',
    };
    expect(sut.validate(formData), null);
  });
}
