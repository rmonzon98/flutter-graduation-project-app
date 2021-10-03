import 'dart:async';
import 'package:automated_data_storage/Providers/DataSender.dart';
import 'package:automated_data_storage/Widgets/AccelerometerTracker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'SpeedTracker.dart';

class HomeSkeleton extends StatefulWidget {
  const HomeSkeleton({Key? key}) : super(key: key);

  @override
  _HomeSkeletonState createState() => _HomeSkeletonState();
}

class _HomeSkeletonState extends State<HomeSkeleton> {
  periodicFunct() {
    saveLocally();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => periodicFunct());
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          backgroundColor: Color(0xff353535),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Automatización de almacenamiento\nde datos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(
                    0xff3c6e71,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SpeedTracker(),
              SizedBox(
                height: 2.h,
              ),
              AccelerometerTracker(),
            ],
          ),
        );
      },
    );
  }
}
