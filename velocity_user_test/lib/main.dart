import 'package:flutter/material.dart';
import 'package:velocity_user_test/Test.dart';
import 'package:velocity_user_test/SetVelocity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SetVelocity(), //login page
        '/test': (context) => Test(),
      },
    );
  }
}
