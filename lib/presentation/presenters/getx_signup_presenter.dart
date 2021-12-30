import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/ui/helpers/errors/ui_error.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class GetxSignupPresenter extends GetxController {
  final Validation validation;

  GetxSignupPresenter({@required this.validation});
  String _email;
  String _password;

  var _emailError = Rx<UIError>();
  var _isFormValid = false.obs;

  void validateEmail(String email) {
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  Stream<UIError> get emailErrorStream => _emailError.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;

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
    _isFormValid.value = _emailError.value == null && _email != null;
  }
}
