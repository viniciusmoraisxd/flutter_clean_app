import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'survey_answer_view_model.dart';

class SurveyResultViewModel  extends Equatable{
  final String surveyId;
  final String question;
  final List<SurveyAnswerViewModel> answers;

  SurveyResultViewModel({
    @required this.surveyId,
    @required this.question,
    @required this.answers,
  });

    List<Object> get props => [surveyId, question, answers];
}
