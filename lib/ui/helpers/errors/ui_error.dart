import 'package:flutter_clean_app/ui/helpers/helpers.dart';

enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  emailInUse,
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.requiredField:
        return R.strings.msgRequiredField;
        break;
      case UIError.invalidField:
        return R.strings.msgInvalidField;
        break;
      case UIError.invalidCredentials:
        return R.strings.msgInvalidCredentials;
        break;
      case UIError.emailInUse:
        return R.strings.msgEmailInUse;
        break;
      default:
        return R.strings.msgUnexpectedError;
    }
  }
}
