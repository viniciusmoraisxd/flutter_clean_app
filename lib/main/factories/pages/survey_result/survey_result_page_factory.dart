import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:get/get.dart';

import '../../factories.dart';

Widget makeSurveyResultPage() => SurveyResultPage(
    makeGetxSurveyResultPresenter(Get.parameters['survey_id']));
