import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SpeedApp(),
    );
  }
}

class SpeedApp extends StatefulWidget {
  const SpeedApp({Key? key}) : super(key: key);

  @override
  _SpeedAppState createState() => _SpeedAppState();
}

class _SpeedAppState extends State<SpeedApp> {
  // For velocity Tracking
  /// Geolocator is used to find velocity
  GeolocatorPlatform locator = GeolocatorPlatform.instance;

  /// Stream that emits values when velocity updates
  StreamController<double> _velocityUpdatedStreamController =
      StreamController<double>();

  /// Current Velocity in m/s
  late double _velocity;

  /// Highest recorded velocity so far in m/s.
  late double _highestVelocity;

  /// Velocity in m/s to km/hr converter
  double mpstokmph(double mps) => mps * 18 / 5;

  /// Callback that runs when velocity updates, which in turn updates stream.
  void _onAccelerate(double speed) {
    locator.getCurrentPosition().then(
      (Position updatedPosition) {
        _velocity = (speed + updatedPosition.speed) / 2;
        if (_velocity > _highestVelocity) _highestVelocity = _velocity;
        _velocityUpdatedStreamController.add(_velocity);
      },
    );
  }

  @override
  void dispose() {
    // Velocity Stream
    _velocityUpdatedStreamController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Speedometer functionality. Updates any time velocity chages.
    locator
        .getPositionStream(
          desiredAccuracy: LocationAccuracy.bestForNavigation,
        )
        .listen(
          (Position position) => _onAccelerate(position.speed),
        );

    // Set velocities to zero when app opens
    _velocity = 0;

    // Set velocities to zero when app opens
    _highestVelocity = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speed tracker prototype"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: _velocityUpdatedStreamController.stream,
              builder: (context, snapshot) {
                return SpeedTracker(
                    velocity: mpstokmph(_velocity),
                    maxVelocity: mpstokmph(_highestVelocity));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SpeedTracker extends StatelessWidget {
  const SpeedTracker(
      {Key? key, required this.velocity, required this.maxVelocity})
      : super(key: key);
  final double velocity;
  final double maxVelocity;

  @override
  Widget build(BuildContext context) {
    final VelocityString = velocity.toStringAsFixed(2);
    return Container(
      child: Text('$VelocityString km/h'),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      margin: EdgeInsets.all(25.0),
      padding: EdgeInsets.all(40.0),
    );
  }
}
