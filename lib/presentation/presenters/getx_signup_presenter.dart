import 'package:flutter_clean_app/domain/usecases/add_account.dart';
import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/ui/helpers/errors/ui_error.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class GetxSignupPresenter extends GetxController {
  final Validation validation;
  final AddAccount addAccount;

  GetxSignupPresenter({@required this.addAccount, @required this.validation});

  String _name;
  String _email;
  String _password;
  String _passwordConfirmation;

  var _nameError = Rx<UIError>();
  var _emailError = Rx<UIError>();
  var _passwordError = Rx<UIError>();
  var _passwordConfirmationError = Rx<UIError>();
  var _isFormValid = false.obs;

  Stream<UIError> get nameErrorStream => _nameError.stream;
  Stream<UIError> get emailErrorStream => _emailError.stream;
  Stream<UIError> get passwordErrorStream => _passwordError.stream;
  Stream<UIError> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  void validateName(String name) {
    _name = name;

    _nameError.value = _validateField(field: 'name', value: name);
    _validateForm();
  }

  void validateEmail(String email) {
    _email = email;

    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;

    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;

    _passwordConfirmationError.value = _validateField(
        field: 'passwordConfirmation', value: passwordConfirmation);
    _validateForm();
  }

  UIError _validateField({@required String field, @required String value}) {
    final error = validation.validate(field: field, value: value);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
        break;
      case ValidationError.requiredField:
        return UIError.requiredField;
        break;
      default:
        return null;
        break;
    }
  }

  void _validateForm() {
    _isFormValid.value = _nameError.value == null &&
        _emailError.value == null &&
        _passwordError.value == null &&
        _passwordConfirmationError.value == null &&
        _name != null &&
        _email != null &&
        _password != null &&
        _passwordConfirmation != null;
  }

  Future<void> signup() async {
    await addAccount.add(AddAccountParams(
        name: _name,
        email: _email,
        password: _password,
        passwordConfirmation: _passwordConfirmation));
  }
}