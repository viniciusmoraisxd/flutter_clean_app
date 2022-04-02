import 'package:meta/meta.dart';

class SurveyResultEntity {
  final String surveyId;
  final String question;
  final bool didAnswer;
  final List<SurveyResultEntity> answers;

  SurveyResultEntity(
      {@required this.surveyId,
      @required this.question,
      @required this.answers,
      @required this.didAnswer});
}
