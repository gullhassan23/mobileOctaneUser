import 'package:cloud_firestore/cloud_firestore.dart';

import 'card_model.dart';

class CustomerModel {
  String? id,
      name,
      phone,
      email,
      password,
      about,
      profile,
      devicetoken,
      address,
      currentvehicle;
  CreditCard? card;

  DateTime? created, updated;
  bool? google, apple, facebook;

  CustomerModel({
    this.devicetoken,
    this.address,
    this.about,
    this.card,
    this.created,
    this.email,
    this.id,
    this.name,
    this.password,
    this.currentvehicle,
    this.phone,
    this.profile,
    this.updated,
    this.apple,
    this.google,
    this.facebook,
  });

  factory CustomerModel.fromMap(var map) {
    return CustomerModel(
      id: map['id'],
      address: map['address'],
      name: map['name'],
      card: map['card'] != null ? CreditCard.fromMap(map['card']) : null,


      currentvehicle: map['currentvehicle'],

      email: map['email'],
      devicetoken: map['devicetoken'],
      phone: map['phone'],
      password: map['password'],
      created: (map['created'] as Timestamp?)?.toDate(),
      updated: (map['updated'] as Timestamp?)?.toDate(),
      about: map['about'],
      profile: map['profile'],
      google: map['google'],
      apple: map['apple'],
      facebook: map['facebook'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'currentvehicle':'currentvehicle',
      'password': password,
      'about': about,
      'profile': profile,
      'devicetoken': devicetoken,
      'address': address,
      'created': created,
      'updated': updated,
      'google': google,
      'card': (card ?? CreditCard()).toMap(),
      'apple': apple,
      'facebook': facebook,
    };
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';

// class CustomerModel {
//   String? id;
//   String? name;
//   String? phone;
//   String? email;
//   String? password;
//   String? about;
//   String? profile;
//   String? devicetoken;
//   String? address;
//   DateTime? created;
//   DateTime? updated;
//   bool? deleted;
//   bool? google;
//   bool? apple;

//   CustomerModel({
//     this.id,
//     this.name,
//     this.phone,
//     this.email,
//     this.password,
//     this.about,
//     this.profile,
//     this.devicetoken,
//     this.address,
//     this.created,
//     this.updated,
//     this.deleted,
//     this.google,
//     this.apple,
//   });

//   // Convert data to a Map
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'phone': phone,
  //     'email': email,
  //     'password': password,
  //     'about': about,
  //     'profile': profile,
  //     'devicetoken': devicetoken,
  //     'address': address,
  //     'created': created,
  //     'updated': updated,
  //     'deleted': deleted,
  //     'google': google,
  //     'apple': apple,
  //   };
  // }

//   // Create a CustomerModel instance from a Firestore document
//       factory CustomerModel.fromMap(Map<String, dynamic> data) {
//     return CustomerModel(
//       id: data['id'],
//       name: data['name'],
//       phone: data['phone'],
//       email: data['email'],
//       password: data['password'],
//       about: data['about'],
//       profile: data['profile'],
//       devicetoken: data['devicetoken'],
//       address: data['address'],
      // created: (data['created'] as Timestamp?)?.toDate(),
      // updated: (data['updated'] as Timestamp?)?.toDate(),
//       deleted: data['deleted'],
//       google: data['google'],
//       apple: data['apple'],
//     );
//   }
// }
