import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/components/components.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';

import './components/components.dart';

class SurveyResultPage extends StatelessWidget {
  final SurveyResultPresenter presenter;

  const SurveyResultPage(this.presenter);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.surveys),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        presenter.isLoadingStream.listen((isLoading) {
          if (isLoading == true) {
            showLoadingDialoag(context);
          } else {
            hideLoadingDialog(context);
          }
        });

        presenter.loadData();

        return StreamBuilder<dynamic>(
            stream: presenter.surveyResultStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ReloadScreen(
                  error: snapshot.error,
                  reload: presenter.loadData,
                );
              }

              if (snapshot.hasData) {
                return SurveyResult();
              }

              return SizedBox.shrink();
            });
      }),
    );
  }
}
