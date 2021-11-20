import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> loadPage(WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);
  }

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

  // testWidgets("Should load with correct initial state",
  //     (WidgetTester tester) async {
  //   loadPage(tester);
  // });
}
