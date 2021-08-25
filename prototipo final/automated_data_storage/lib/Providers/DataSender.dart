import 'package:geolocator/geolocator.dart';

Future<List> retrieveData() async {
  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation);
  var lat = position.latitude;
  var long = position.longitude;
  DateTime dateTime = DateTime.now();

  return [lat, long, dateTime];
}
