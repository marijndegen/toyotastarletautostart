import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusText extends StatelessWidget {
  final bool blockUserInput;

  final int carStatus;

  const StatusText({Key key, this.blockUserInput, this.carStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

              return MediaQuery.of(context).orientation == Orientation.portrait
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ...this.texts(theme),
                        ],
                      ),
                      SizedBox(
                        child: Padding(padding: EdgeInsets.all(5),),
                      ),
                      blockUserInput 
                      ? CircularProgressIndicator() 
                      : Container(
                        width: 40,
                        height: 40,
                      )
                    ],
                  )
                : Column(
                  children: <Widget>[
                    ...this.texts(theme),
                      SizedBox(
                        child: Padding(padding: EdgeInsets.all(5),),
                      ),
                      blockUserInput 
                      ? CircularProgressIndicator() 
                      : Container(
                        width: 40,
                        height: 40,
                      )
                  ],
                );
    
    // Column(
    //   children: <Widget>[
    //     //Header


    //     //Status
    //     Column(
    //       children: <Widget>[
    //         Text('Engine status', style: theme.textTheme.display1,),
    //         blockUserInput ? Text('Attempting to fulfill your request..') :
    //         !blockUserInput && carStatus == -100 ? Text("Unable to give accurate status. - 100") :
    //         !blockUserInput && carStatus == -3  ? Text('The car is not running -3') :
    //         !blockUserInput && carStatus == -2  ? Text('The car is not running -2') :
    //         !blockUserInput && carStatus == -1  ? Text('The car is not running -1') :
    //         !blockUserInput && carStatus >= 0  ? Text('The car is running 0 +') : 
    //         Text('Attempting to fetch car status'),

    //         SizedBox(
    //           child: Padding(padding: EdgeInsets.all(5),),
    //         ),

    //         blockUserInput 
    //         ? CircularProgressIndicator() 
    //         : Container(
    //           width: 40,
    //           height: 40,
    //         )

    //       ],
    //     )
    //   ],
    // );
  }

  List<Widget> texts (ThemeData theme) {
      return [
        Text('Engine status', style: theme.textTheme.display1,),
        blockUserInput ? Text('Attempting to fulfill your request..') :
        !blockUserInput && carStatus == -100 ? Text("Unable to give accurate status. - 100") :
        !blockUserInput && carStatus == -3  ? Text('The car is not running -3') :
        !blockUserInput && carStatus == -2  ? Text('The car is not running -2') :
        !blockUserInput && carStatus == -1  ? Text('The car is not running -1') :
        !blockUserInput && carStatus >= 0  ? Text('The car is running 0 +') : 
        Text('Attempting to fetch car status')
      ];
  }

}