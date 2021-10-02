import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_user_test/Arguments.dart';
import 'package:velocity_user_test/SpeedGUI.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  double velocity = 0;
  late Timer timer;
  int secondsTime = 0;
  var maxVal;
  var minVal;
  var timeInterval;

  void addSecond() {
    setState(
      () {
        secondsTime = secondsTime + 1;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) {
        timer = Timer.periodic(
          Duration(seconds: 1),
          (timer) {
            addSecond();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  var maxTime;
  bool flag = false;

  void checkIfCrash() {
    var nowTime = DateTime.now().millisecondsSinceEpoch;
    if (velocity >= maxVal) {
      maxTime = nowTime;
      flag = true;
    }
    if (flag) {
      if ((nowTime - maxTime <= (timeInterval * 1000)) && velocity <= minVal) {
        print('posible accidente');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Se ha detectado un posible accidente',
              ),
              content: Text(
                  'Se ha detectado un posible accidente en el segundo ' +
                      secondsTime.toString() +
                      ' con los parametros que usted ingreso'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        secondsTime = 0;
                        velocity = 0;
                      },
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Continuar'),
                )
              ],
            );
          },
        );
      }
    }
    if (velocity <= minVal) {
      flag = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ArgumentsClass;
    maxVal = args.maxVel;
    if (args.maxVel != null) {
      maxVal = args.maxVel;
    } else {
      maxVal = 0;
    }
    if (args.minVel != null) {
      minVal = args.minVel;
    } else {
      minVal = 0;
    }
    if (args.timeInterval != null) {
      timeInterval = args.timeInterval;
    } else {
      timeInterval = 0;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(
          0xff3c6e71,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 100,
            vertical: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'velocidad minima ' +
                    minVal.toString() +
                    ' velocidad maxima ' +
                    maxVal.toString(),
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              Text(
                'Tiempo que ha transcurrido:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              Text(
                secondsTime.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SpeedUI(
                velocity: velocity,
                endGreen: args.maxVel,
              ),
              SizedBox(
                height: 40,
              ),
              Slider(
                onChanged: (newRating) {
                  setState(
                    () {
                      velocity = newRating;
                      checkIfCrash();
                    },
                  );
                },
                min: 0,
                max: 240,
                value: velocity,
                label: velocity.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
