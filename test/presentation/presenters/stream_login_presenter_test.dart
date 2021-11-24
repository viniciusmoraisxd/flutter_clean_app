import 'package:faker/faker.dart';
import 'package:flutter_clean_app/presentation/presenters/presenters.dart';
import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  ValidationSpy validation;
  StreamLoginPresenter sut;
  String email;

  PostExpectation mockValidationCall({String field}) =>
      when(validation.validate(
          field: field == null ? anyNamed('field') : field,
          value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field: field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });

  test('Should call validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit emailerror if validation fails', () {
    mockValidation(value: 'error');

    //garante que só vai emitir quando houver ação diferente da anterior
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));


    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
  });
}
