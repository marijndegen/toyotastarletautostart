import 'package:auto_flutter_app/components/Buttons/control_view_model.dart';
import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget{
  
  final ControlViewModel vm;

  final IconData icon;

  final Color color;

  const ControlButton({Key key, this.vm, this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
              onPressed: () {
                vm.executeButtonFuction();
              },
              backgroundColor: color,
              child: Icon(
                icon,
                size: 150,
              ),
            );
  }
  
}