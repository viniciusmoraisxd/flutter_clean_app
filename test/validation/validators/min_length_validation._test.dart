import 'package:faker/faker.dart';
import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/validation/protocols/protocols.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class MinLengthValidation implements FieldValidation {
  final String field;
  final int minLength;

  MinLengthValidation({@required this.field, @required this.minLength});

  @override
  ValidationError validate(String value) {
    // final isValid = value?.isNotEmpty != true || value.length > 3;

    // return isValid ? null : ValidationError.invalidField;
    return value != null && value.length >= minLength
        ? null
        : ValidationError.invalidField;
  }
}

void main() {
  MinLengthValidation sut;

  setUp(() {
    sut = MinLengthValidation(field: 'any_field', minLength: 5);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), ValidationError.invalidField);
  });

  test('Should return an error if value less than minLength', () {
    expect(sut.validate(faker.randomGenerator.string(4, min: 1)),
        ValidationError.invalidField);
  });

  test('Should return an null if value is equal than minLength', () {
    expect(sut.validate(faker.randomGenerator.string(5, min: 5)), null);
  });

  test('Should return an null if value is bigger than minLength', () {
    expect(sut.validate(faker.randomGenerator.string(10, min: 6)), null);
  });
}
