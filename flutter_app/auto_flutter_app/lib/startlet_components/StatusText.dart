import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusText extends StatelessWidget {
  final bool blockUserInput;

  final int status;

  const StatusText({Key key, this.blockUserInput, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: <Widget>[
        //Header
        Text('Engine status', style: theme.textTheme.display1,),

        //Status
        blockUserInput ? Column(
          children: <Widget>[
            Text('Attempting to fulfill your request..'),

            SizedBox(
              child: Padding(padding: EdgeInsets.all(5),),
            ),

            CircularProgressIndicator(),
          ],
        ) :
        !blockUserInput && status == -100 ? Text("Unable to give accurate status. - 100") :
        !blockUserInput && status == -3  ? Text('The car is not running -3') :
        !blockUserInput && status == -2  ? Text('The car is not running -2') :
        !blockUserInput && status == -1  ? Text('The car is not running -1') :
        !blockUserInput && status >= 0  ? Text('The car is running 0 +') :
        Column(
          children: <Widget>[
            Text('Attempting to fetch car status'),

            SizedBox(
              child: Padding(padding: EdgeInsets.all(5),),
            ),

            CircularProgressIndicator(),
          ],
        ),
      ],
    );
  }

}