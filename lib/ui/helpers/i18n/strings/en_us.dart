import 'translations.dart';

class EnUs implements Translations {
  @override
  String get msgInvalidCredentials => "Invalid Credentials.";

  @override
  String get msgInvalidField => "Invalid Field.";

  @override
  String get msgRequiredField => "Required Field.";

  @override
  String get msgUnexpectedError => "Something went wrong. Try again later.";

  @override
  String get addAccount => 'Add account';

  @override
  String get email => "E-mail";

  @override
  String get enter => "Enter";

  @override
  String get login => "Login";

  @override
  String get password => "Password";
}
