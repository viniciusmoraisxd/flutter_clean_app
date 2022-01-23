import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/components/components.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';

import 'components/components.dart';

class SurveysPage extends StatelessWidget {
  final SurveysPresenter presenter;

  SurveysPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    presenter.loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.surveys),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading == true) {
              showLoadingDialoag(context);
            } else {
              hideLoadingDialog(context);
            }
          });

          return StreamBuilder<List<SurveysViewModel>>(
              stream: presenter.surveysStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      Text(snapshot.error),
                      RaisedButton(
                        child: Text(R.strings.reload),
                        onPressed: presenter.loadData,
                      )
                    ],
                  );
                }

                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CarouselSlider(
                      items: snapshot.data
                          .map((viewModel) => SurveyItem(viewModel))
                          .toList(),
                      options: CarouselOptions(
                          enlargeCenterPage: true, aspectRatio: 1),
                    ),
                  );
                }

                return SizedBox.shrink();
              });
        },
      ),
    );
  }
}
