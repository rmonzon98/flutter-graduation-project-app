import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:sizer/sizer.dart';

class SpeedUI extends StatelessWidget {
  const SpeedUI(
      {Key? key,
      required this.velocity,
      required this.dateNow,
      required this.flagCrash})
      : super(key: key);

  final double velocity;
  final int dateNow;
  final bool flagCrash;

  @override
  Widget build(BuildContext context) {
    final velocityString = velocity.toStringAsFixed(2);
    return Sizer(builder: (context, orientation, deviceType) {
      return Column(
        children: [
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 240,
                interval: 10,
                ranges: [
                  GaugeRange(
                    startValue: 0,
                    endValue: 60,
                    color: Colors.green,
                  ),
                  GaugeRange(
                    startValue: 60,
                    endValue: 240,
                    color: Colors.red,
                  )
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                    value: double.parse(velocityString),
                    enableAnimation: true,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      velocityString,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    positionFactor: 0.5,
                    angle: 90,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            () {
              if (flagCrash) {
                Fluttertoast.showToast(
                  msg: "Se ha detectado un accidente",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                return 'Hubo un posible accidente.';
              } else {
                return 'No ha habido variación en la velocidad \n          causante de un accidente';
              }
            }(),
          )
        ],
      );
    });
  }
}
