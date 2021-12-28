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
  StreamController<UIError> mainErrorController;
  StreamController<bool> isFormValidController;
  StreamController<bool> isLoadingController;

  void initStreams() {
    nameErrorController = StreamController<UIError>();
    emailErrorController = StreamController<UIError>();
    passwordErrorController = StreamController<UIError>();
    passwordConfirmationErrorController = StreamController<UIError>();
    mainErrorController = StreamController<UIError>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
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

    when(presenter.mainErrorStream)
        .thenAnswer((_) => mainErrorController.stream);

    when(presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
  }

  void closeStreams() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
    mainErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
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
        of: find.bySemanticsLabel("Confirmar senha"),
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

    await tester.enterText(find.bySemanticsLabel('Confirmar senha'), password);
    verify(presenter.validatePasswordConfirmation(password));
  });

  testWidgets("Should present name error", (WidgetTester tester) async {
    await loadPage(tester);

    nameErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido.'), findsOneWidget);

    nameErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório.'), findsOneWidget);

    nameErrorController.add(null);
    await tester.pump();
    expect(
        find.descendant(
            of: find.bySemanticsLabel("Nome"), matching: find.byType(Text)),
        findsOneWidget);
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

  testWidgets("Should present password error", (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido.'), findsOneWidget);

    passwordErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório.'), findsOneWidget);

    passwordErrorController.add(null);
    await tester.pump();
    expect(
        find.descendant(
            of: find.bySemanticsLabel("Senha"), matching: find.byType(Text)),
        findsOneWidget);
  });

  testWidgets("Should present password confirmation error",
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordConfirmationErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido.'), findsOneWidget);

    passwordConfirmationErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório.'), findsOneWidget);

    passwordConfirmationErrorController.add(null);
    await tester.pump();
    expect(
        find.descendant(
            of: find.bySemanticsLabel("Confirmar senha"),
            matching: find.byType(Text)),
        findsOneWidget);
  });

  testWidgets("Should enable button if form is valid",
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);

    await tester.pump();

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(button.onPressed, isNotNull);
  });

  testWidgets("Should disable button if form is invalid",
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(false);

    await tester.pump();

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(button.onPressed, isNull);
  });

  testWidgets("Should call signup on form submit", (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);

    await tester.pump();
    final button = find.byType(RaisedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(presenter.signup()).called(1);
  });

  testWidgets("Should present loading on form submit",
      (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("Should hide loading on form submit end",
      (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets("Should present a message if Signup fails",
      (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add(UIError.emailInUse);
    await tester.pump();

    expect(find.text("O e-mail já está em uso."), findsOneWidget);
  });

  testWidgets("Should present a message if Signup throws",
      (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add(UIError.unexpected);
    await tester.pump();

    expect(find.text("Algo errado aconteceu. Tente novamente em breve."),
        findsOneWidget);
  });
}
