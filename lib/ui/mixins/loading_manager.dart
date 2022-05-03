import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/components/components.dart';

mixin LoadingManager {
  void handleLoading(
      {@required BuildContext context, @required Stream<bool> stream}) {
    stream.listen((isLoading) {
      if (isLoading == true) {
        showLoadingDialoag(context);
      } else {
        hideLoadingDialog(context);
      }
    });
  }
}
