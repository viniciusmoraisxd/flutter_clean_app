import 'package:flutter_clean_app/data/http/http.dart';
import 'package:flutter_clean_app/domain/entities/entities.dart';
import 'package:meta/meta.dart';

class RemoteSurveyAnswerModel {
  final String image;
  final bool isCurrentAccountAnswer;
  final String answer;
  final int percent;

  RemoteSurveyAnswerModel({
    this.image,
    @required this.isCurrentAccountAnswer,
    @required this.answer,
    @required this.percent,
  });

  factory RemoteSurveyAnswerModel.fromJson(Map json) {
    if (!json.keys
        .toSet()
        .containsAll(['answer', 'isCurrentAccountAnswer', 'percent'])) {
      throw HttpError.invalidData;
    }
    return RemoteSurveyAnswerModel(
      image: json['image'],
      isCurrentAccountAnswer: json['isCurrentAccountAnswer'],
      answer: json['answer'],
      percent: json['percent'],
    );
  }

  SurveyAnswerEntity toEntity() => SurveyAnswerEntity(
      image: image,
      isCurrentAnswer: isCurrentAccountAnswer,
      percent: percent,
      answer: answer);
}
