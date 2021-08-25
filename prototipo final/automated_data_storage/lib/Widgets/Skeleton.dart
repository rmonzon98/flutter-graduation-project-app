import 'package:automated_data_storage/Widgets/AccelerometerTracker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'SpeedTracker.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Automatización de almacenamiento de datos',
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
