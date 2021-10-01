import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<List> retrieveData() async {
  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation);
  var lat = position.latitude;
  var long = position.longitude;
  DateTime dateTime = DateTime.now();

  return [lat, long, dateTime];
}

Future velocityCrash() async {
  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation);
  var lat = position.latitude;
  var long = position.longitude;
  DateTime dateTime = DateTime.now();
  print('Se ha detectado un posible accidente con la velocidad');
  print('lat: ' + lat.toString());
  print('long: ' + long.toString());
  print('date: ' + dateTime.toString());
  Fluttertoast.showToast(
    msg: "Se ha detectado un accidente",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
