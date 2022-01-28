import 'package:flutter_clean_app/domain/entities/entities.dart';
import 'package:meta/meta.dart';

class LocalSurveyModel {
  final String id;
  final String question;
  final DateTime date;
  final bool didAnswer;

  LocalSurveyModel({
    @required this.id,
    @required this.question,
    @required this.date,
    @required this.didAnswer,
  });

  factory LocalSurveyModel.fromJson(Map json) {
    if (!json.keys
        .toSet()
        .containsAll(['id', 'question', 'date', 'didAnswer'])) {
      throw Exception();
    }

    return LocalSurveyModel(
      id: json['id'],
      question: json['question'],
      date: DateTime.parse(json['date']),
      didAnswer: json['didAnswer'] == "true",
    );
  }

  SurveyEntity toEntity() => SurveyEntity(
      id: id, question: question, date: date, didAnswer: didAnswer);

  factory LocalSurveyModel.fromEntity(SurveyEntity entity) => LocalSurveyModel(
        id: entity.id,
        question: entity.question,
        date: entity.date,
        didAnswer: entity.didAnswer,
      );

  Map<String, String> toJson() => {
        'id': id,
        'question': question,
        'date': date.toIso8601String(),
        'didAnswer': didAnswer.toString()
      };
}
