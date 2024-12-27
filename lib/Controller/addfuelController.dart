import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_octane/global/refs.dart';

import '../Model/FuelUp_model.dart';
import '../Model/Location.dart';
import '../Model/fuel_model.dart';
import '../Model/notificationmodel.dart';
import '../Model/vehicle_model.dart';
import '../services/services/user_services.dart';

class AddFuelController extends GetxController {
  //  List<Map<String, dynamic>> _placesData = [];
  RxList<Map<String, dynamic>> placesData = <Map<String, dynamic>>[].obs;
  Fuel? selectedFuel;
  TextEditingController timeController = TextEditingController();
  TextEditingController fuellitterController = TextEditingController();
  TextEditingController pricefuelController = TextEditingController();
  double totalliter = 0.0;
  double totalprice = 0.0;
  TimeOfDay? selectedTime;
  //location
  final TextEditingController searchController = TextEditingController();
  Location locationdetail = Location();
  VehicleDetails? selectedVehicledetail;

  Future<void> addfuel() async {
    UserServices _userServices = Get.find<UserServices>();
    String id = fuelTransaction.doc().id;
    FuelUp fuelUp = FuelUp(
      id: id,
      createdAt: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime!.hour,
        selectedTime!.minute,
      ),
      fuel: selectedFuel!,
      price: totalprice,
      liters: totalliter,
      location: locationdetail,
      vehicleDetails: selectedVehicledetail!,
    );
    fuelTransaction
        .doc(_userServices.customer.id)
        .collection("Transaction")
        .doc(fuelUp.id)
        .set(fuelUp.toMap());
    String documentId = notificationRef.doc().id;
    NotificationModel notification = NotificationModel(
        title: "Fill Me Up",
        body: "Fuel Added Successfully",
        id: documentId,
        transactionid: fuelUp.id,
        senderid: "");

    notificationRef
        .doc(_userServices.customer.id)
        .collection("notification")
        .doc(documentId) // Set the generated document ID
        .set(notification.toMap());
  }
}
