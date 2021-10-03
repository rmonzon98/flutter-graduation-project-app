import 'package:dart_application_1/dart_application_1.dart'
    as dart_application_1;
import 'package:postgres/postgres.dart';

void funct() async {
  var connection = PostgreSQLConnection("localhost", 5432, "demo",
      username: "postgres", password: "raul1998");
  await connection.open();
  await connection.query(
      "INSERT INTO possible_accidents (lat, long) VALUES (@a, @b)",
      substitutionValues: {"a": "2312", "b": "481.21"});
  print('prueba');
}

void main(List<String> arguments) {
  funct();
  print('Hello world: ${dart_application_1.calculate()}!');
}
