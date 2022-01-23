import 'package:meta/meta.dart';

class SurveysViewModel {
  final String id;
  final String question;
  final String date;
  final bool didAnswer;

  SurveysViewModel(
      {@required this.id,
      @required this.question,
      @required this.date,
      @required this.didAnswer});
}
