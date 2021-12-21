import 'package:flutter_clean_app/ui/helpers/i18n/strings/translations.dart';

class PtBr implements Translations {
  @override
  String get msgInvalidCredentials => "Credenciais inválidas.";

  @override
  String get msgInvalidField => "Campo inválido.";

  @override
  String get msgRequiredField => "Campo obrigatório.";
  
  @override
  String get msgUnexpectedError =>
      "Algo errado aconteceu. Tente novamente em breve.";

  @override
  String get addAccount => 'Criar conta';

  @override
  String get email => "E-mail";

  @override
  String get enter => "Entrar";

  @override
  String get login => "Login";

  @override
  String get password => "Senha";
}
