import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/components/components.dart';
import 'package:flutter_clean_app/ui/helpers/errors/errors.dart';

mixin UIErrorManager {
  void handleError(
      {@required BuildContext context, @required Stream<UIError> stream}) {
    stream.listen((error) {
      if (error != null) {
        showErrorMessage(context, error.description);
      }
    });
  }
}
