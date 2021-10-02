import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedUI extends StatelessWidget {
  const SpeedUI({Key? key, required this.velocity, required this.endGreen})
      : super(key: key);

  final double velocity;
  final double endGreen;

  @override
  Widget build(BuildContext context) {
    final velocityString = velocity.toStringAsFixed(2);
    return Column(
      children: [
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 240,
              interval: 20,
              ranges: [
                GaugeRange(
                  startValue: 0,
                  endValue: endGreen,
                  color: Colors.green,
                ),
                GaugeRange(
                  startValue: endGreen,
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
      ],
    );
  }
}
