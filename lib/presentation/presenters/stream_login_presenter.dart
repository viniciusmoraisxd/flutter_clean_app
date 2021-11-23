import 'dart:async';

import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:meta/meta.dart';

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  StreamLoginPresenter({@required this.validation});

  var _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct(); //não emite valores seguidos iguais

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}

class LoginState {
  String emailError;
}
