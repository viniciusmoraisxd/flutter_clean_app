import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:flutter_clean_app/presentation/mixins/mixins.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class GetxSplashPresenter extends GetxController
    with NavigateManager
    implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  GetxSplashPresenter({@required this.loadCurrentAccount});

  @override
  Future<void> checkAccount({int durationInSeconds = 2}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try {
      final account = await loadCurrentAccount.load();
      navigateTo = account?.token == null ? '/login' : '/surveys';
    } catch (e) {
      navigateTo = '/login';
    }
  }
}
