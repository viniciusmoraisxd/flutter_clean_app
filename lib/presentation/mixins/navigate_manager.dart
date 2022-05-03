import 'package:get/get.dart';

mixin NavigateManager on GetxController {
  var _navigateTo = RxString();
  Stream<String> get navigateToStream => _navigateTo.stream;
  set navigateTo(String value) => _navigateTo.value = value;
}
