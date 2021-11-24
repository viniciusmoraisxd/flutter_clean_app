import 'dart:async';

import 'package:flutter_clean_app/domain/helpers/domain_error.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:meta/meta.dart';

class StreamLoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final _controller = StreamController<LoginState>.broadcast();

  StreamLoginPresenter(
      {@required this.validation, @required this.authentication});

  var _state = LoginState();
  Stream<String> get mainErrorStream =>
      _controller.stream.map((state) => state.mainError).distinct();
  Stream<String> get emailErrorStream => _controller.stream
      .map((state) => state.emailError)
      .distinct(); //não emite valores seguidos iguais

  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  Stream<bool> get isLoadingStream =>
      _controller.stream.map((state) => state.isLoading).distinct();

  void updateState() => _controller.add(_state);

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    updateState();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    updateState();
  }

  Future<void> auth() async {
    _state.isLoading = true;
    updateState();
    try {
      await authentication.auth(
          AuthenticationParams(email: _state.email, secret: _state.password));
    } on DomainError catch (e) {
      _state.mainError = e.description;
    }
    _state.isLoading = false;
    updateState();
  }
}

class LoginState {
  String mainError;
  String email;
  String emailError;
  String password;
  String passwordError;
  bool isLoading = false;
  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      password != null &&
      email != null;
}
