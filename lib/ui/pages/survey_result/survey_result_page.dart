import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';

class SurveyResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.surveys),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
                padding:
                    EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor.withAlpha(90)),
                child: Text("Qual é o seu framework web favorito"));
          }

          return Column(
            children: [
              Container(
                color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      "http://fordevs.herokuapp.com/static/img/logo-angular.png",
                      width: 40,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Angular",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Text("100%",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark)),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(Icons.check_circle,
                          color: Theme.of(context).disabledColor.withAlpha(90)),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              )
            ],
          );
        },
        itemCount: 4,
      ),
    );
  }
}
