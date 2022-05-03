import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/components/components.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';

import 'package:provider/provider.dart';
import '../../mixins/mixins.dart';

import 'components/components.dart';

class SurveysPage extends StatelessWidget
    with LoadingManager, NavigateManager, SessionManager {
  final SurveysPresenter presenter;

  SurveysPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.surveys),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          handleLoading(context: context, stream: presenter.isLoadingStream);
          handleSessionExpired(
              context: context, stream: presenter.isSessionExpiredStream);
          handleNavigation(
              context: context, stream: presenter.navigateToStream);

          presenter.loadData();

          return StreamBuilder<List<SurveysViewModel>>(
              stream: presenter.surveysStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ReloadScreen(
                    error: snapshot.error,
                    reload: presenter.loadData,
                  );
                }

                if (snapshot.hasData) {
                  return Provider(
                    create: (_) => presenter,
                    child: SurveyItems(viewModels: snapshot.data),
                  );
                }

                return SizedBox.shrink();
              });
        },
      ),
    );
  }
}
