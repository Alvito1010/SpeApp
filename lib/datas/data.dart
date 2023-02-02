import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.ref();

class Device {
  final String sensorName;
  final String location;
  bool isWarning;
  final String imageUrl;

  Device(
      {required this.sensorName,
      required this.isWarning,
      required this.location,
      required this.imageUrl});
}
