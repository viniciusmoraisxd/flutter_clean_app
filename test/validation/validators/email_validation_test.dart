import 'package:faker/faker.dart';
import 'package:flutter_clean_app/presentation/protocols/validation.dart';
import 'package:flutter_clean_app/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null on invalid cases', () {
    expect(sut.validate({}), null);
  });
  
  test('Should return null if email is empty', () {
    expect(sut.validate({'any_field': ''}), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate({'any_field': null}), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate({'any_field': faker.internet.email()}), null);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate({'any_field': 'vinicius.morais'}),
        ValidationError.invalidField);
  });
}
