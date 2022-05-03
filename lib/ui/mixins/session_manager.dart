import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin SessionManager {
  void handleSessionExpired(
      {@required BuildContext context, @required Stream<bool> stream}) {
    stream.listen((isExpired) {
      if (isExpired == true) {
        Get.offAllNamed('/login');
      }
    });
  }
}
