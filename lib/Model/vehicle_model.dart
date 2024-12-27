import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleDetails {
  final String id;
  final String vehicleColor;
  final String vehiclename;

  final String licensePlateNumber;
  final String year;
  final String make;
  final String model;
  final DateTime created;
  DateTime? updated; // Use Timestamp? to represent a nullable Timestamp

  VehicleDetails({
    required this.id,
    required this.vehicleColor,
    required this.vehiclename,

    required this.licensePlateNumber,
    required this.year,
    required this.make,
    required this.model,
    required this.created,
    this.updated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicleColor': vehicleColor,
      'vehiclename': vehiclename,

      'licensePlateNumber': licensePlateNumber,
      'year': year,
      'make': make,
      'model': model,
      'created': created ,
      'updated': updated ?? DateTime.now(),
    };
  }

  factory VehicleDetails.fromMap(Map<String, dynamic> map) {
    return VehicleDetails(
      id: map['id'],
      vehicleColor: map['vehicleColor'],
      vehiclename: map['vehiclename'],

      licensePlateNumber: map['licensePlateNumber'],
      year: map['year'],
      make: map['make'],
      model: map['model'],
      created: map['created'].toDate(),
      updated: map['updated'].toDate(),
    );
  }
}
