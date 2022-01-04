import 'package:meta/meta.dart';

class SurveyEntity {
  final String id;
  final String question;
  final DateTime date;
  final bool didAnswer;

  SurveyEntity(
      {@required this.id,
      @required this.question,
      @required this.date,
      @required this.didAnswer});
}
