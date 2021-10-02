import 'package:flutter/material.dart';
import 'package:velocity_user_test/Arguments.dart';

class SetVelocity extends StatefulWidget {
  const SetVelocity({Key? key}) : super(key: key);

  @override
  _SetVelocityState createState() => _SetVelocityState();
}

class _SetVelocityState extends State<SetVelocity> {
  double timeInterval = 1;
  double minVel = 0;
  double maxVel = 10;
  @override
  Widget build(BuildContext context) {
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
                'Intervalo de tiempo: ' + timeInterval.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Slider(
                onChanged: (newRating) {
                  setState(
                    () {
                      timeInterval = newRating;
                    },
                  );
                },
                min: 1,
                max: 5,
                value: timeInterval,
                divisions: 4,
                label: timeInterval.toString(),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Velocidad minima: ' + minVel.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Slider(
                onChanged: (newRating) {
                  setState(
                    () {
                      minVel = newRating.roundToDouble();
                    },
                  );
                },
                min: 0,
                max: 10,
                divisions: 10,
                value: minVel,
                label: minVel.toString(),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Velocidad máxima: ' + maxVel.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Slider(
                onChanged: (newRating) {
                  setState(
                    () {
                      maxVel = newRating.roundToDouble();
                    },
                  );
                },
                min: 10,
                max: 240,
                divisions: 23,
                value: maxVel,
                label: maxVel.toString(),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/test',
                    arguments: ArgumentsClass(
                      minVel: minVel,
                      maxVel: maxVel,
                      timeInterval: timeInterval,
                    ),
                  );
                },
                child: Text('Siguiente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
