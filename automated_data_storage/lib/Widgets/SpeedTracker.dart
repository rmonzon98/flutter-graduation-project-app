import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sizer/sizer.dart';
import 'SpeedUI.dart';
import 'package:automated_data_storage/Providers/DataSender.dart';

class SpeedTracker extends StatefulWidget {
  const SpeedTracker({Key? key}) : super(key: key);

  @override
  _SpeedTrackerState createState() => _SpeedTrackerState();
}

class _SpeedTrackerState extends State<SpeedTracker> {
  // Velocidad pivote
  double _pivotVelocity = 0.4;

// Velocidad más baja a la que debe llegar para que se tome como incidente
  double _lowestVelocity = 0.3;

  // Tiempo que debe pasar para que llegue a 0 para que se tome como incidente
  double _pivotTime = 10;

  // Velocidad actual en m/s
  double _velocity = 0;

  // flag de que ya llego al limite de velocidad
  bool _flagSpeed = false;

  // flag para posible incidente
  bool _flagCrash = false;

  // Hora que se registra velocidad mayor a 60
  int _dateNowM = 0;

  //Hora actual
  int _dateNow = 0;

  // Instancia del geolocator
  GeolocatorPlatform locator = GeolocatorPlatform.instance;

  // Stream que se utiliza para recibir los valores cambiantes de la velocidad
  StreamController<double> _velocityUpdatedStreamController =
      StreamController<double>();

  // Función para cambiar velocidad de m/s a km/h
  double mpstokmph(double mps) => mps * 18 / 5;

  // Callback that runs when velocity updates, which in turn updates stream.
  void _onAccelerate(double speed) {
    locator.getCurrentPosition().then(
      // Se pasa la posición actual como parametro
      (Position updatedPosition) {
        _dateNow = DateTime.now().millisecondsSinceEpoch; //Se toma el epoch
        _velocity = (speed + updatedPosition.speed) / 2; // Se calcula velocidad
        //Se actualiza la velocidad actual
        _velocityUpdatedStreamController.add(_velocity);
        if (_pivotVelocity < mpstokmph(_velocity)) {
          _dateNowM = DateTime.now().millisecondsSinceEpoch;
        }
        if (_dateNow - _dateNowM > 0 &&
            _dateNow - _dateNowM < (_pivotTime * 1000) &&
            mpstokmph(_velocity) < _lowestVelocity) {
          _flagCrash = true;
          velocityCrash();
          _speedStream.pause(
            Future.delayed(
              const Duration(seconds: 3),
            ),
          );
        } else {
          _flagCrash = false;
        }
      },
    );
  }

  // Disposer del stream
  @override
  void dispose() {
    // Velocity Stream
    super.dispose();
    _speedStream.cancel();
  }

  late StreamSubscription _speedStream;

  /* Al iniciar la aplicación se configura el stream y se pone la velocidad 
  inicial en 0*/
  @override
  void initState() {
    super.initState();
    //Se configura el listener de la velocidad
    _speedStream = locator
        .getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation)
        .listen(
      (Position position) {
        _onAccelerate(position.speed);
      },
    );
    // Se coloca las velocidades en 0 al iniciar el app
    _velocity = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: _velocityUpdatedStreamController.stream,
                builder: (context, snapshot) {
                  return SpeedUI(
                    velocity: mpstokmph(_velocity),
                    dateNow: _dateNow,
                    flagCrash: _flagCrash,
                  );
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
