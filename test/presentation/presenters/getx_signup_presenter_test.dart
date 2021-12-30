import 'package:faker/faker.dart';
import 'package:flutter_clean_app/presentation/presenters/presenters.dart';
import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/ui/helpers/errors/errors.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  ValidationSpy validation;
  GetxSignupPresenter sut;
  String email;
  PostExpectation mockValidationCall({String field}) =>
      when(validation.validate(
          field: field == null ? anyNamed('field') : field,
          value: anyNamed('value')));

  void mockValidation({String field, ValidationError value}) {
    mockValidationCall(field: field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = GetxSignupPresenter(validation: validation);
    email = faker.internet.email();

    mockValidation(); //success validation
  });

  test('Should call validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit invalid field if email is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    //garante que só vai emitir quando houver ação diferente da anterior
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
  });

  test('Should emit required field error if email is empty', () {
    mockValidation(value: ValidationError.requiredField);

    //garante que só vai emitir quando houver ação diferente da anterior
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
  });

  test('Should emit null if email validation succeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });
}
