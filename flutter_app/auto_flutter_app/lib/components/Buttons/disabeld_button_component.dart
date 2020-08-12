
import 'package:auto_flutter_app/components/Buttons/control_button.dart';
import 'package:flutter/material.dart';

final Color _disabledColor = Colors.grey;

class DisabeldButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) => 
    ControlButton(vm: null, color: _disabledColor, icon: Icons.stop);
}
