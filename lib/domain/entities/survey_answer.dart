import 'package:meta/meta.dart';

class SurveyAnswer {
  final String image;
  final bool isCurrentAnswer;
  final String answer;
  final int percent;

  SurveyAnswer(
      {this.image,
      @required this.isCurrentAnswer,
      @required this.answer,
      @required this.percent});
}
