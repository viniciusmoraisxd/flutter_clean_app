import 'package:flutter/material.dart';

class DisabledIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Icon(Icons.check_circle,
          color: Theme.of(context).disabledColor.withAlpha(90)),
    );
  }
}
