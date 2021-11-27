import 'package:flutter_clean_app/validation/validators/required_field_validation.dart';
import 'package:flutter_clean_app/validation/validators/validation_composite.dart';
import 'package:flutter_clean_app/validation/validators/validators.dart';

ValidationComposite makeValidationComposite() => ValidationComposite([
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
    ]);
