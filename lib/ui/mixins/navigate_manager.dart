import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin NavigateManager {
  void handleNavigation(
      {@required BuildContext context, @required Stream<String> stream}) {
    stream.listen((page) {
      if (page?.isNotEmpty == true) {
        Get.offAllNamed(page);
      }
    });
  }
}
