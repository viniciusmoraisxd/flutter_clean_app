import 'package:flutter_clean_app/presentation/protocols/protocols.dart';
import 'package:flutter_clean_app/validation/protocols/protocols.dart';
import 'package:meta/meta.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  ValidationError validate({@required String field, @required Map input}) {
    ValidationError error;
    for (final validation
        in validations.where((element) => element.field == field)) {
      error = validation.validate(input);
      if (error != null) {
        return error;
      }
    }
    return error;
  }
}
