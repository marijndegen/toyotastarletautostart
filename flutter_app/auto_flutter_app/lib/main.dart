import 'package:auto_flutter_app/ToyotaStartlet.dart';
import 'package:auto_flutter_app/starlet_service/car_interface.dart';
import 'package:flutter/material.dart';

/*

 */

void main() {

  CarInterfaceService cis = new CarInterfaceService();

  runApp(MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ToyotaStarlet(cis))
  );
}
