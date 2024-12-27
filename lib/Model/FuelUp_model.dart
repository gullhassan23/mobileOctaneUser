import 'fuel_model.dart';
import 'vehicle_model.dart';
import 'Location.dart';

class FuelUp {
  final String id;
  final DateTime createdAt;
  final double price;
  final double liters;
  final Location location; // Use the Location class for the location details
  final VehicleDetails vehicleDetails;
  final Fuel fuel;

  FuelUp({
    required this.id,
    required this.createdAt,
    required this.price,
    required this.liters,
    required this.location,
    required this.vehicleDetails,
    required this.fuel,
  });

  // Convert Map to FuelUp object
  factory FuelUp.fromMap(Map<String, dynamic> map) {
    return FuelUp(
      id: map['id'],
      createdAt: map['createdAt'].toDate(),
      price: map['price'],
      liters: map['liters'],
      location: Location.fromMap(map['location']),
      vehicleDetails: VehicleDetails.fromMap(map['vehicleDetails']),
      fuel: Fuel.fromMap(map['fuel']),
    );
  }

  // Convert FuelUp object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'price': price,
      'liters': liters,
      'location': location.toMap(),
      'vehicleDetails': vehicleDetails.toMap(),
      'fuel': fuel.toMap(),
    };
  }
}
