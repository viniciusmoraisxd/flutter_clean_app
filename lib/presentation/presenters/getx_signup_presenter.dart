import 'package:flutter_clean_app/domain/helpers/helpers.dart';
import 'package:flutter_clean_app/domain/usecases/add_account.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:flutter_clean_app/presentation/mixins/mixins.dart';
import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/ui/helpers/errors/ui_error.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class GetxSignupPresenter extends GetxController
    with LoadingManager, NavigateManager, UIErrorManager, FormManager
    implements SignupPresenter {
  final Validation validation;
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;

  GetxSignupPresenter({
    @required this.addAccount,
    @required this.validation,
    @required this.saveCurrentAccount,
  });

  String _name;
  String _email;
  String _password;
  String _passwordConfirmation;

  var _nameError = Rx<UIError>();
  var _emailError = Rx<UIError>();
  var _passwordError = Rx<UIError>();
  var _passwordConfirmationError = Rx<UIError>();

  Stream<UIError> get nameErrorStream => _nameError.stream;
  Stream<UIError> get emailErrorStream => _emailError.stream;
  Stream<UIError> get passwordErrorStream => _passwordError.stream;
  Stream<UIError> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;

  void validateName(String name) {
    _name = name;

    _nameError.value = _validateField('name');
    _validateForm();
  }

  void validateEmail(String email) {
    _email = email;

    _emailError.value = _validateField('email');
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;

    _passwordError.value = _validateField('password');
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;

    _passwordConfirmationError.value = _validateField('passwordConfirmation');
    _validateForm();
  }

  UIError _validateField(field) {
    final formData = {
      'name': _name,
      'email': _email,
      'password': _password,
      'passwordConfirmation': _passwordConfirmation
    };

    final error = validation.validate(field: field, input: formData);
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
    isFormValid = _nameError.value == null &&
        _emailError.value == null &&
        _passwordError.value == null &&
        _passwordConfirmationError.value == null &&
        _name != null &&
        _email != null &&
        _password != null &&
        _passwordConfirmation != null;
  }

  Future<void> signup() async {
    try {
      mainError = null;
      isLoading = true;

      final account = await addAccount.add(AddAccountParams(
          name: _name,
          email: _email,
          password: _password,
          passwordConfirmation: _passwordConfirmation));

      await saveCurrentAccount.save(account);

      navigateTo = '/surveys';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.emailInUse:
          mainError = UIError.emailInUse;
          break;
        default:
          mainError = UIError.unexpected;
          break;
      }
      isLoading = false;
    }
  }

  void goToLogin() {
    navigateTo = '/login';
  }
}
