import 'package:flutter/material.dart';

mixin KeyboardManager {
  void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    print(currentFocus.hasPrimaryFocus);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
