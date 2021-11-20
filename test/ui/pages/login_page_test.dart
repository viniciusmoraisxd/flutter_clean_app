import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenterSpy presenter;
  StreamController<String> emailErrorController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String>();

    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();
  });

  testWidgets("Should load with correct initial state",
      (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel("E-mail"), matching: find.byType(Text));

    expect(emailTextChildren, findsOneWidget,
        reason: "when a TextFormField has only one text child, means it has "
            "no erros, since one of the childs is always the hint text");
    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel("Senha"), matching: find.byType(Text));

    expect(passwordTextChildren, findsOneWidget,
        reason: "when a TextFormField has only one text child, means it has "
            "no erros, since one of the childs is always the hint text");

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(button.onPressed, null);
  });

  testWidgets("Should call validates with correct values",
      (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('E-mail'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(presenter.validatePassword(password));
  });

  testWidgets("Should present error if email is invalid",
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('any_error');
    await tester.pump();

    expect(find.text('any_error'), findsOneWidget);
  });
  testWidgets("Should present no error if email is valid",
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(null);
    await tester.pump();

    expect(
        find.descendant(
            of: find.bySemanticsLabel("E-mail"), matching: find.byType(Text)),
        findsOneWidget);
  });

  testWidgets("Should present no error if email is valid",
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add("");
    await tester.pump();

    expect(
        find.descendant(
            of: find.bySemanticsLabel("E-mail"), matching: find.byType(Text)),
        findsOneWidget);
  });
}
