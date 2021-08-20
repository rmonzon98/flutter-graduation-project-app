import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SensorsApp(),
    );
  }
}

class SensorsApp extends StatefulWidget {
  const SensorsApp({Key? key}) : super(key: key);

  @override
  _SensorsAppState createState() => _SensorsAppState();
}

class _SensorsAppState extends State<SensorsApp> {
  void getInformationAcelerometer(eventData) {
    setState(() {
      _accelerometerValues = <double>[eventData.x, eventData.y, eventData.z];
      _check = true;
    });
  }

  bool _check = false;
  List<double>? _accelerometerValues;

  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final flag = _check;
    return Scaffold(
      appBar: AppBar(
        title: Text("User Accelerometer data prototype"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.screen_rotation,
              size: 75.0,
              color: Colors.green,
            ),
            SizedBox(
              height: 25.0,
            ),
            Text('Accelerometer data',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 18.0,
            ),
            Text("Información del telefono con la gravedad: $accelerometer"),
            SizedBox(
              height: 18.0,
            ),
            Text((() {
              if (flag) {
                return "x: " +
                    accelerometer!.elementAt(0) +
                    " y: " +
                    accelerometer.elementAt(1) +
                    " z: " +
                    accelerometer.elementAt(2);
              } else {
                return '';
              }
            }())),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen(
      (AccelerometerEvent event) {
        getInformationAcelerometer(event);
      },
    );
  }
}
