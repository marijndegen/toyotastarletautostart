import 'package:flutter/material.dart';

class InstructionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: <Widget>[
        Text('Start engine', style: theme.textTheme.display1,),

        Text('800MS for a hot engine\n1000MS for a cold engine\n1100MS for the winter morning\n1250MS+ for when the car is trashed\n', style: theme.textTheme.body1, textAlign: TextAlign.center,),

        Text('Please select a proper start engine power time:', style: theme.textTheme.body1, textAlign: TextAlign.center,),
      ],
    );
  }
}