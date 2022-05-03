import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import '../../mixins/mixins.dart';

class SplashPage extends StatelessWidget with NavigateManager {
  final SplashPresenter presenter;

  const SplashPage({Key key, @required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();
    return Scaffold(
      appBar: AppBar(
        title: Text('4Dev'),
      ),
      body: Builder(builder: (context) {
        handleNavigation(context: context, stream: presenter.navigateToStream);
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
