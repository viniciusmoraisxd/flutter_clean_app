import 'package:flutter/material.dart';

import '../survey_result_view_model.dart';

class SurveyResult extends StatelessWidget {
  final SurveyResultViewModel viewModel;

  const SurveyResult({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
              padding:
                  EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withAlpha(90)),
              child: Text(viewModel.question));
        }

        return Column(
          children: [
            Container(
              color: Theme.of(context).backgroundColor,
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  viewModel.answers[index - 1].image != null
                      ? Image.network(
                          viewModel.answers[index - 1].image,
                          width: 40,
                        )
                      : SizedBox.shrink(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        viewModel.answers[index - 1].answer,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Text(viewModel.answers[index - 1].percent,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark)),
                  viewModel.answers[index - 1].isCurrentAnswer
                      ? ActiveIcon()
                      : DisabledIcon()
                ],
              ),
            ),
            Divider(
              height: 1,
            )
          ],
        );
      },
      itemCount: viewModel.answers.length + 1,
    );
  }
}

class ActiveIcon extends StatelessWidget {
  const ActiveIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Icon(Icons.check_circle, color: Theme.of(context).highlightColor),
    );
  }
}

class DisabledIcon extends StatelessWidget {
  const DisabledIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Icon(Icons.check_circle,
          color: Theme.of(context).disabledColor.withAlpha(90)),
    );
  }
}
