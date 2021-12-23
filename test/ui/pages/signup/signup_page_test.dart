import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class SignupPresenterSpy extends Mock implements SignupPresenter {}

void main() {
  Future<void> loadPage(WidgetTester tester) async {
    final signupPage = GetMaterialApp(
      initialRoute: '/signup',
      getPages: [
        GetPage(
          name: '/signup',
          page: () => SignupPage(),
        ),
      ],
    );
    await tester.pumpWidget(signupPage);
  }

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
}
