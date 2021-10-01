import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:automated_data_storage/Providers/DataSender.dart';

class AccelerometerTracker extends StatefulWidget {
  const AccelerometerTracker({Key? key}) : super(key: key);

  @override
  _AccelerometerTrackerState createState() => _AccelerometerTrackerState();
}

class _AccelerometerTrackerState extends State<AccelerometerTracker> {
  double maxForce = 15.0; // Valor máximo permitido en todos los ejes
  late StreamSubscription _accStream;
  bool _check = false;
  List<double> _accelerometerValues = [0, 0, 0];
  List<double> _accelerometerValuesCrash = [0, 0, 0];

  void getInformationAcelerometer(eventData) {
    bool posibleCrash = false;
    if (eventData.x > maxForce ||
        eventData.y > maxForce ||
        eventData.z > maxForce) {
      posibleCrash = true;
      _accStream.cancel();
      _accelerometerValuesCrash = [eventData.x, eventData.y, eventData.z];
    }
    setState(() {
      _accelerometerValues = <double>[eventData.x, eventData.y, eventData.z];
      _check = posibleCrash;
    });
  }

  Future<void> _sendData() async {
    List list = await retrieveData();
    print('Se ha detectado una actividad muy brusca en en los acelerometros');
    print(
        'Los datos recolectados son con los sensores ($_accelerometerValuesCrash):');
    print('lat: ' + list.elementAt(0).toString());
    print('long: ' + list.elementAt(1).toString());
    print('date: ' + list.elementAt(2).toString());
    Fluttertoast.showToast(
      msg: "Se ha detectado un accidente",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    _check = false;
    _accStream = accelerometerEvents.listen(
      (AccelerometerEvent event) {
        getInformationAcelerometer(event);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _accStream.cancel();
  }

  @override
  void initState() {
    super.initState();
    _accStream = accelerometerEvents.listen(
      (AccelerometerEvent event) {
        getInformationAcelerometer(event);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues.map((double v) => v.toStringAsFixed(1)).toList();
    final flag = _check;
    if (flag) {
      _sendData();
    }
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    () {
                      if (accelerometer.isEmpty) {
                        return 'x: 0';
                      } else {
                        return 'x: ' + accelerometer.elementAt(0);
                      }
                    }(),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    () {
                      if (accelerometer.isEmpty) {
                        return 'y: 0';
                      } else {
                        return 'y: ' + accelerometer.elementAt(1);
                      }
                    }(),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    () {
                      if (accelerometer.isEmpty) {
                        return 'z: 0';
                      } else {
                        return 'z: ' + accelerometer.elementAt(2);
                      }
                    }(),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
