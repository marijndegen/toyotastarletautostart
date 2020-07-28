import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

final Color _disabledColor = Colors.grey;
final Color _startColor = Colors.green;
final Color _stopColor = Colors.red;
final Color _disconnectedColor = Colors.blue;

class ControlButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
            margin: EdgeInsets.all(15),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: SizedBox(
                width: 280,
                height: 280,
                child: FloatingActionButton(
              onPressed: () async {
                // startListening();

                // //Set the state to attempting to start and put the car in contact.
                // setState(() {
                //   _blockUserInput = true;
                // });

                // if (_isContactOff()) {
                //   await widget.cis.startContact();
                // }

                // await widget.cis.sleep(
                //     400); //Give 400MS between the moment of contact and the starting process.

                // //Attempt to start the car.
                // await widget.cis.ignite(int.parse(_selectedStartTime));

                // //Check after 3000 MS if the car started successfully.
                // await widget.cis.sleep(
                //     3000); //Give 3000MS between the moment of starting and the check if the car started successfully.

                // //Change the values, based on the outcome of the car.
                // setState(() {
                //   _blockUserInput = false;
                // });
              },
              backgroundColor: _startColor,
              child: Icon(
                Icons.play_circle_filled,
                size: 150,
              ),
            )));
  }
}