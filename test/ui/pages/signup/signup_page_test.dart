import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class SignupPresenterSpy extends Mock implements SignupPresenter {}

void main() {
  SignupPresenterSpy presenter;
  StreamController<UIError> nameErrorController;
  StreamController<UIError> emailErrorController;
  StreamController<UIError> passwordErrorController;
  StreamController<UIError> passwordConfirmationErrorController;

  void initStreams() {
    nameErrorController = StreamController<UIError>();
    emailErrorController = StreamController<UIError>();
    passwordErrorController = StreamController<UIError>();
    passwordConfirmationErrorController = StreamController<UIError>();
  }

  void mockStreams() {
    when(presenter.nameErrorStream)
        .thenAnswer((_) => nameErrorController.stream);

    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);

    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);

    when(presenter.passwordConfirmationErrorStream)
        .thenAnswer((_) => passwordConfirmationErrorController.stream);
  }

  void closeStreams() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SignupPresenterSpy();
    initStreams();
    mockStreams();

    final signupPage = GetMaterialApp(
      initialRoute: '/signup',
      getPages: [
        GetPage(
          name: '/signup',
          page: () => SignupPage(presenter),
        ),
      ],
    );
    await tester.pumpWidget(signupPage);
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets("Should load with correct initial state",
      (WidgetTester tester) async {
    await loadPage(tester);

    final nameTextChildren = find.descendant(
        of: find.bySemanticsLabel("Nome"), matching: find.byType(Text));

    expect(nameTextChildren, findsOneWidget,
        reason: "when a TextFormField has only one text child, means it has "
            "no erros, since one of the childs is always the hint text");

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel("E-mail"), matching: find.byType(Text));

    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel("Senha"), matching: find.byType(Text));

    expect(passwordTextChildren, findsOneWidget);

    final passwordConfirmationTextChildren = find.descendant(
        of: find.bySemanticsLabel("Confirmar Senha"),
        matching: find.byType(Text));

    expect(passwordConfirmationTextChildren, findsOneWidget);

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets("Should call validates with correct values",
      (WidgetTester tester) async {
    await loadPage(tester);

    final name = faker.person.name();
    await tester.enterText(find.bySemanticsLabel('Nome'), name);
    verify(presenter.validateName(name));

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('E-mail'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(presenter.validatePassword(password));

    await tester.enterText(find.bySemanticsLabel('Confirmar Senha'), password);
    verify(presenter.validatePasswordConfirmation(password));
  });

  testWidgets("Should present email error", (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido.'), findsOneWidget);

    emailErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório.'), findsOneWidget);

    emailErrorController.add(null);
    await tester.pump();
    expect(
        find.descendant(
            of: find.bySemanticsLabel("E-mail"), matching: find.byType(Text)),
        findsOneWidget);
  });
}
