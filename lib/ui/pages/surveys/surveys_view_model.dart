import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SurveysViewModel extends Equatable {
  final String id;
  final String question;
  final String date;
  final bool didAnswer;

  SurveysViewModel(
      {@required this.id,
      @required this.question,
      @required this.date,
      @required this.didAnswer});

  @override
  List<Object> get props => [id, question, date, didAnswer];
}
