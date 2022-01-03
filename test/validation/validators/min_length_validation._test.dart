import 'package:faker/faker.dart';
import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  MinLengthValidation sut;

  setUp(() {
    sut = MinLengthValidation(field: 'any_field', minLength: 5);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate({'any_field': ''}), ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    expect(sut.validate({'any_field': null}), ValidationError.invalidField);
  });

  test('Should return an error if value less than minLength', () {
    expect(sut.validate({'any_field': faker.randomGenerator.string(4, min: 1)}),
        ValidationError.invalidField);
  });

  test('Should return an null if value is equal than minLength', () {
    expect(sut.validate({'any_field': faker.randomGenerator.string(5, min: 5)}),
        null);
  });

  test('Should return an null if value is bigger than minLength', () {
    expect(
        sut.validate({'any_field': faker.randomGenerator.string(10, min: 6)}),
        null);
  });
}
