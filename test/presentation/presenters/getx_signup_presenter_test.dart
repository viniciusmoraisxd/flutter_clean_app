import 'package:faker/faker.dart';
import 'package:flutter_clean_app/domain/entities/entities.dart';
import 'package:flutter_clean_app/domain/helpers/helpers.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:flutter_clean_app/presentation/presenters/presenters.dart';
import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/ui/helpers/errors/errors.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ValidationSpy extends Mock implements Validation {}

class AddAccountSpy extends Mock implements AddAccount {}

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {}

void main() {
  ValidationSpy validation;
  AddAccountSpy addAccount;
  SaveCurrentAccountSpy saveCurrentAccount;
  GetxSignupPresenter sut;
  String name;
  String email;
  String password;
  String passwordConfirmation;
  String token;
  PostExpectation mockValidationCall({String field}) =>
      when(validation.validate(
          field: field == null ? anyNamed('field') : field,
          input: anyNamed('input')));
  PostExpectation mockAddAccountCall() => when(addAccount.add(any));
  PostExpectation mockSaveCurrentAccountCall() =>
      when(saveCurrentAccount.save(any));

  void mockValidation({String field, ValidationError value}) {
    mockValidationCall(field: field).thenReturn(value);
  }

  void mockAddAccount() {
    mockAddAccountCall().thenAnswer((_) async => AccountEntity(token));
  }

  void mockAddAccountError(DomainError error) {
    mockAddAccountCall().thenThrow(error);
  }

  void mockSaveCurrentAccountError() {
    mockSaveCurrentAccountCall().thenThrow(DomainError.unexpected);
  }

  setUp(() {
    validation = ValidationSpy();
    addAccount = AddAccountSpy();
    saveCurrentAccount = SaveCurrentAccountSpy();
    sut = GetxSignupPresenter(
        validation: validation,
        addAccount: addAccount,
        saveCurrentAccount: saveCurrentAccount);
    name = faker.person.name();
    email = faker.internet.email();
    password = faker.internet.password();
    passwordConfirmation = password;
    token = faker.guid.guid();

    mockValidation(); //success validation
    mockAddAccount();
  });

  test('Should call validation with correct name', () {
    final formData = {
      'name': name,
      'email': null,
      'password': null,
      'passwordConfirmation': null,
    };

    sut.validateName(name);

    verify(validation.validate(field: 'name', input: formData)).called(1);
  });

  test('Should emit invalid field if name is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    //garante que só vai emitir quando houver ação diferente da anterior
    sut.nameErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
  });

  test('Should emit required field error if name is empty', () {
    mockValidation(value: ValidationError.requiredField);

    //garante que só vai emitir quando houver ação diferente da anterior
    sut.nameErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
  });

  test('Should emit null if name validation succeds', () {
    sut.nameErrorStream.listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should call validation with correct email', () {
    final formData = {
      'name': null,
      'email': email,
      'password': null,
      'passwordConfirmation': null,
    };
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', input: formData)).called(1);
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

  test('Should call validation with correct password', () {
    final formData = {
      'name': null,
      'email': null,
      'password': password,
      'passwordConfirmation': null,
    };
    sut.validatePassword(password);

    verify(validation.validate(field: 'password', input: formData)).called(1);
  });

  test('Should emit invalid field if password is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    //garante que só vai emitir quando houver ação diferente da anterior
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
  });

  test('Should emit required field error if password is empty', () {
    mockValidation(value: ValidationError.requiredField);

    //garante que só vai emitir quando houver ação diferente da anterior
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
  });

  test('Should emit null if password validation succeds', () {
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should call validation with correct passwordConfirmation', () {
    final formData = {
      'name': null,
      'email': null,
      'password': null,
      'passwordConfirmation': passwordConfirmation,
    };
    sut.validatePasswordConfirmation(passwordConfirmation);

    verify(validation.validate(
            field: 'passwordConfirmation', input: formData))
        .called(1);
  });

  test('Should emit invalid field if passwordConfirmation is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    //garante que só vai emitir quando houver ação diferente da anterior
    sut.passwordConfirmationErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should emit required field error if passwordConfirmation is empty', () {
    mockValidation(value: ValidationError.requiredField);

    //garante que só vai emitir quando houver ação diferente da anterior
    sut.passwordConfirmationErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should emit null if passwordConfirmation validation succeds', () {
    sut.passwordConfirmationErrorStream
        .listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should enable form button if all fields are valid', () async {
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateName(name);
    await Future.delayed(Duration.zero);
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
    await Future.delayed(Duration.zero);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should call AddAccount with correct values', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    await sut.signup();

    verify(addAccount.add(
      AddAccountParams(
          name: name,
          email: email,
          password: password,
          passwordConfirmation: passwordConfirmation),
    )).called(1);
  });

  test('Should call SaveCurrentAccount with correct values', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    await sut.signup();

    verify(saveCurrentAccount.save(AccountEntity(token))).called(1);
  });

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async {
    mockSaveCurrentAccountError();
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.unexpected)));

    await sut.signup();
  });

  test('Should emit correct events on AddAccount success', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(sut.isLoadingStream, emits(true));

    await sut.signup();
  });

  test('Should emit correct events on EmailInUseError', () async {
    mockAddAccountError(DomainError.emailInUse);
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.emailInUse)));

    await sut.signup();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAddAccountError(DomainError.unexpected);
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.unexpected)));

    await sut.signup();
  });

  test('Should change page on AddAccount success', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.signup();
  });

  test('Should go to login page on link click', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    sut.goToLogin();
  });
}
