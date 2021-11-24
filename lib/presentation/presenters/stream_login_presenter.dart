import 'dart:async';

import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:meta/meta.dart';

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  StreamLoginPresenter({@required this.validation});

  var _state = LoginState();

  Stream<String> get emailErrorStream => _controller.stream
      .map((state) => state.emailError)
      .distinct(); //não emite valores seguidos iguais

  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  void updateState() => _controller.add(_state);

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    updateState();
  }

  void validatePassword(String password) {
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    updateState();
  }
}

class LoginState {
  String emailError;
  String passwordError;
  bool get isFormValid => false;
}
