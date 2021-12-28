import 'package:flutter_clean_app/ui/helpers/helpers.dart';

abstract class SignupPresenter {
  Stream<UIError> get nameErrorStream;
  Stream<UIError> get emailErrorStream;
  Stream<UIError> get passwordErrorStream;
  Stream<UIError> get passwordConfirmationErrorStream;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmation);
}
