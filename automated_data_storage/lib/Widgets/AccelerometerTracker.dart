import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:automated_data_storage/Providers/DataSender.dart';

class AccelerometerTracker extends StatefulWidget {
  const AccelerometerTracker({Key? key}) : super(key: key);

  @override
  _AccelerometerTrackerState createState() => _AccelerometerTrackerState();
}

class _AccelerometerTrackerState extends State<AccelerometerTracker> {
  double maxForce = 40.0; // Valor máximo permitido en todos los ejes
  late StreamSubscription _accStream;
  List<double> _accelerometerValues = [0, 0, 0];
  var lastEvent;

  void getInformationAcelerometer(eventData) {
    lastEvent = DateTime.now().millisecondsSinceEpoch;
    if (eventData.x > maxForce ||
        eventData.y > maxForce ||
        eventData.z > maxForce) {
      _accStream.cancel();
      _sendData();
    }
    setState(
      () {
        _accelerometerValues = <double>[
          eventData.x,
          eventData.y,
          eventData.z,
        ];
      },
    );
  }

  void _sendData() async {
    var nowTime = DateTime.now().millisecondsSinceEpoch;
    if (nowTime - lastEvent <= 50) {
      lastEvent = nowTime;
      await detectedCrash(false, context);
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
        () {
          _accStream = accelerometerEvents.listen(
            (AccelerometerEvent event) {
              getInformationAcelerometer(event);
            },
          );
        },
      );
    }
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
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Center(
          child: Column(
            children: [
              Text(
                'Aceleración necesaria: $maxForce',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Slider(
                  onChanged: (newval) {
                    setState(
                      () {
                        maxForce = newval;
                      },
                    );
                  },
                  min: 10,
                  max: 100,
                  divisions: 9,
                  value: maxForce,
                  label: maxForce.toString(),
                ),
              ),
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
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(
                        0xff3c6e71,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
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
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(
                        0xff3c6e71,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
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
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(
                        0xff3c6e71,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
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
