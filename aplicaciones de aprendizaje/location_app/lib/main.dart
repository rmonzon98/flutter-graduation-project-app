import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationApp(),
    );
  }
}

class LocationApp extends StatefulWidget {
  const LocationApp({Key? key}) : super(key: key);

  @override
  _LocationAppState createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  var locationMessage = "";
  var date = "";

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var lastPosition = await Geolocator.getLastKnownPosition();
    var lat = position.latitude;
    var long = position.longitude;
    DateTime dateTime = DateTime.now();
    print(lastPosition);
    print(dateTime);

    setState(() {
      locationMessage = "Latitud: $lat, Longitud: $long";
      date = "Date: " + dateTime.toIso8601String();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location App Prototype'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 75.0,
              color: Colors.green,
            ),
            SizedBox(
              height: 25.0,
            ),
            Text('Get User Location',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 18.0,
            ),
            Text("$locationMessage"),
            Text("$date"),
            TextButton(
                onPressed: () {
                  getCurrentLocation();
                },
                child: Text('Get Current Location'))
          ],
        ),
      ),
    );
  }
}
