import 'package:flutter/material.dart';
import 'package:flutter_clean_app/ui/helpers/helpers.dart';

class ReloadScreen extends StatelessWidget {
  final String error;
  final Future<void> Function() reload;
  const ReloadScreen({
    @required this.error,
    @required this.reload,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          RaisedButton(
            child: Text(R.strings.reload),
            onPressed: reload,
          )
        ],
      ),
    );
  }
}