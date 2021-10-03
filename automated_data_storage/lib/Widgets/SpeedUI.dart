import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:sizer/sizer.dart';

class SpeedUI extends StatelessWidget {
  const SpeedUI(
      {Key? key,
      required this.velocity,
      required this.dateNow,
      required this.flagCrash,
      required this.minVel,
      required this.maxVel})
      : super(key: key);

  final double velocity;
  final int dateNow;
  final bool flagCrash;
  final double minVel;
  final double maxVel;

  @override
  Widget build(BuildContext context) {
    final velocityString = velocity.toStringAsFixed(2);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Column(
          children: [
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 240,
                  interval: 20,
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: 0,
                      endValue: minVel,
                      color: Colors.green,
                    ),
                    GaugeRange(
                      startValue: minVel,
                      endValue: maxVel,
                      color: Colors.yellow,
                    ),
                    GaugeRange(
                      startValue: maxVel,
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
                          color: Colors.white,
                          fontSize: 20,
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
              (flagCrash)
                  ? 'Hubo un posible accidente.'
                  : 'Rastreando velocidad',
              style: TextStyle(
                color: Color(
                  0xff3c6e71,
                ),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          ],
        );
      },
    );
  }
}
