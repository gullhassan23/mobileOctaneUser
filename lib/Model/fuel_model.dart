import 'package:cloud_firestore/cloud_firestore.dart';

class Fuel {
  String name;
  double pricePerLiter;
  Timestamp createdat;

  Fuel({
    required this.name,
    required this.pricePerLiter,
    required this.createdat,
  });

  // Convert Firestore document snapshot to Fuel object
  factory Fuel.fromSnapshot(DocumentSnapshot snapshot) {
    return Fuel(
      name: snapshot['name'],
      pricePerLiter: snapshot['PricePerLiter'].toDouble(),
      createdat: snapshot['createdat'],
    );
  }

  // Convert Fuel object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'PricePerLiter': pricePerLiter,
      'createdat': createdat,
    };
  }
    factory Fuel.fromMap(Map<String, dynamic> map) {
    return Fuel(
      name: map['name'],
      pricePerLiter: map['PricePerLiter'].toDouble(),
      createdat: map['createdat'],
    );
  }
}
