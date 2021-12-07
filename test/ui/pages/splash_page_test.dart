import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('4Dev'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

void main() {
  testWidgets('Should present a spinner on page load',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => SplashPage()),
        ],
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
