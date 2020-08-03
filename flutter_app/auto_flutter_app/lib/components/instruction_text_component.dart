import 'package:flutter/material.dart';


class InstructionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: <Widget>[

        Text('Start engine', style: theme.textTheme.display1,),
      
      //Text(ipAdress),

        Text('Please select a proper start engine power time:\n', style: theme.textTheme.body1, textAlign: TextAlign.center,),
      
        Text('800MS for a hot engine,\n 1000MS for a cold engine,\n 1100MS for the winter morning,\n 1250MS+ for when the car is trashed.', style: theme.textTheme.body1, textAlign: TextAlign.center,),
      ],
    );
  }
}