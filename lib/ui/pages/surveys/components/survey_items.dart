import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../surveys.dart';
import 'survey_item.dart';

class SurveyItems extends StatelessWidget {
  final List<SurveysViewModel> viewModels;
  const SurveyItems({
    Key key,
    @required this.viewModels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        items: viewModels.map((viewModel) => SurveyItem(viewModel)).toList(),
        options: CarouselOptions(enlargeCenterPage: true, aspectRatio: 1),
      ),
    );
  }
}
