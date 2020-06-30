import 'package:flutter/material.dart';

class OutputText extends StatelessWidget {
  final String output;

  OutputText({this.output});

  @override
  Widget build(BuildContext context) {
    return Text(
      output,
      style: Theme.of(context).textTheme.display2,
    );
  }
}
