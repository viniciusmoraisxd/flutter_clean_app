import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SurveyAnswerViewModel extends Equatable {
  final String image;
  final bool isCurrentAnswer;
  final String answer;
  final String percent;

  SurveyAnswerViewModel(
      {this.image,
      @required this.isCurrentAnswer,
      @required this.answer,
      @required this.percent});

  List<Object> get props => [image, isCurrentAnswer, answer, percent];
}
