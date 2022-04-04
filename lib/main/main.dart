import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_app/main/factories/factories.dart';
import 'package:flutter_clean_app/ui/components/components.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:get/get.dart';

void main() {
  R.load(Locale('en', 'US'));
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: 'Flutter - TDD, Clean Arch and SOLID',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: '/survey_result/3',
      getPages: [
        GetPage(name: '/', page: makeSplashPage, transition: Transition.fade),
        GetPage(
            name: '/login', page: makeLoginPage, transition: Transition.fadeIn),
        GetPage(
            name: '/signup', page: makeSignupPage),
        GetPage(
            name: '/surveys',
            page: makeSurveysPage,
            transition: Transition.fadeIn),
        GetPage(
            name: '/survey_result/:survey_id',
            page: makeSurveyResultPage),
      ],
    );
  }
}
