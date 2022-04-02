import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SurveyAnswerEntity extends Equatable {
  final String image;
  final bool isCurrentAnswer;
  final String answer;
  final int percent;

  SurveyAnswerEntity(
      {this.image,
      @required this.isCurrentAnswer,
      @required this.answer,
      @required this.percent});

  @override
  List<Object> get props => ['image', 'isCurrentAnswer', 'answer', 'percent'];
}
