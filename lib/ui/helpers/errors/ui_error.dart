import 'package:flutter_clean_app/ui/helpers/helpers.dart';

enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
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
      default:
        return R.strings.msgUnexpectedError;
    }
  }
}
