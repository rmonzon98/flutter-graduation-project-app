import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Widgets/Skeleton.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ],
    );
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeSkeleton(),
    );
  }
}
