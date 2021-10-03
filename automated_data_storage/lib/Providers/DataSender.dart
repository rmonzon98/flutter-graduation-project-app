import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:postgres/postgres.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

Future saveLocally() async {
  final prefs = await SharedPreferences.getInstance();
  print(prefs.getString('info') ?? ' ');
  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation);
  var lat = position.latitude;
  var long = position.longitude;
  DateTime dateTime = DateTime.now();
  String nowTime = dateFormat.format(dateTime);
  Fluttertoast.showToast(
    msg:
        "Se ha actualizado información local $lat, $long con datetime $nowTime",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
  prefs.setString('info', "$lat, $long $nowTime");
}

Future detectedCrash(bool tipo, var context) async {
  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation);
  var lat = position.latitude;
  var long = position.longitude;
  DateTime dateTime = DateTime.now();
  String nowTime = dateFormat.format(dateTime);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          (tipo)
              ? 'Se ha detectado un posible accidente con el GPS'
              : 'Se ha detectado un posible accidente con acelerometros',
        ),
        content: Text(
          'Se ha detectado un posible accidente en el segundo en las coordenadas' +
              lat.toString() +
              ', ' +
              long.toString() +
              ' al rededor de las ' +
              nowTime,
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Continuar'),
          )
        ],
      );
    },
  );
  return [lat.toString(), long.toString(), nowTime];
}

void sendData() async {
  var connection = PostgreSQLConnection("localhost", 5432, "demo",
      username: "postgres", password: "raul1998");
  await connection.open();
}
