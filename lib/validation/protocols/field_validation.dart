import 'package:flutter_clean_app/presentation/protocols/protocols.dart';

abstract class FieldValidation {
  String get field;
  ValidationError validate(Map input);
}