import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_octane/main3.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:xor_encryption/xor_encryption.dart';
import 'package:http/http.dart' as http;
import '../../global/refs.dart';
import '../Model/customer_model.dart';
import '../Widgets/shimmer.dart';
import '../constant/strings.dart';
import '../main.dart';

class UserController extends GetxController {
  RxBool login = false.obs;
  Rx<CustomerModel> user = CustomerModel().obs;
  // Rx<SettingModel> settings = SettingModel().obs;
  String serverkey =
      "key=";

  String get userid => user.value.id ?? '';

  Future<bool> checkUserLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    login.value = prefs.getBool(AppStrings.auth) ?? false;
    if (login.value) {
      String userid = prefs.getString(AppStrings.userid) ?? '';
      await getUserDetails(userid);
    }
    // print("login ${login.value}");
    return login.value;
  }

  getUserDetails(String userid,
      {String password = '', bool isAuth = false}) async {
    customersRef.doc(userid).snapshots().listen((snapshot) async {
      if (snapshot.exists) {
        user.value = CustomerModel.fromMap(snapshot.data());

        print("eeee user ${user.value.toMap()}");
          CustomEasyLoading.dismiss();
        
        // if (user.value.password != password && isAuth == true) {
        //   await customersRef.doc(userid).update({
        //     'password': XorCipher().encryptData(password, AppStrings.xorkey),
        //   });
        //   user.value.password = password;
        // }
        if (user.value.apple == false && user.value.google == false) {
          // user.value.password = XorCipher().encryptData(
          //   user.value.password!,
          //   AppStrings.xorkey,
          // );
          CustomEasyLoading.dismiss();

          Get.log(user.value.password!);
        }
      }
    });
  }

  // getSettings(String id) async {
  //   await settingsRef.doc(id).get().then((value) async {
  //     if (value.data() == null) {
  //       settings.value.id = id;
  //       await settingsRef.doc(id).set(settings.value.toMap());
  //       await settingsRef.doc(id).get().then((setting) {
  //         settings.value = SettingModel.fromMap(setting.data());
  //       });
  //     } else {
  //       settings.value = SettingModel.fromMap(value.data());
  //     }
  //   });
  // }

  logout() {
    login.value = false;
    user.value = CustomerModel();
    // settings.value = SettingModel();
  }

  updatePassword(String password) async {
    user.value.password = XorCipher().encryptData(password, AppStrings.xorkey);
    password = XorCipher().encryptData(password, AppStrings.xorkey);

    await customersRef.doc(userid).update({'password': password});
    await getUserDetails(userid);
  }

  updateProfile({
    required String name,
    required String email,
    required String image,
  }) async {
    user.value.name = name;
    user.value.email = email;
    user.value.profile = image;
    await customersRef.doc(user.value.id).update(user.value.toMap());
    await getUserDetails(userid);
    update();
  }
}
