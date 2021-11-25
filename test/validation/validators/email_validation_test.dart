import 'package:flutter_clean_app/validation/protocols/protocols.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  @override
  String validate(String value) {
    return null;
  }
}

void main() {
  test('Should return null if email is null', () {
    final sut = EmailValidation('any_value');

    final error = sut.validate(null);

    expect(error, null);
  });
}
