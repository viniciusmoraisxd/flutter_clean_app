import 'package:meta/meta.dart';

class SurveyAnswerViewModel {
  final String image;
  final bool isCurrentAnswer;
  final String answer;
  final String percent;

  SurveyAnswerViewModel(
      {this.image,
      @required this.isCurrentAnswer,
      @required this.answer,
      @required this.percent});
}
