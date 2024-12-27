class Location {
  double? lat;
  double? lng;
  String? address;
  String? city;
  String? country;
  String? state;

  Location({
     this.lat,
     this.lng,
     this.address,
     this.city,
     this.country,
     this.state,
  });

  // Convert Map to Location object
  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: map['lat'],
      lng: map['lng'],
      address: map['address'],
      city: map['city'],
      country: map['country'],
      state: map['state'],
    );
  }

  // Convert Location object to a Map
  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
      'address': address,
      'city': city,
      'country': country,
      'state': state,
    };
  }
}
