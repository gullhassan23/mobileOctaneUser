import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_octane/Widgets/toast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xor_encryption/xor_encryption.dart';
import '../Controller/user_controller.dart';
import '../Model/customer_model.dart';
import '../Widgets/shimmer.dart';
import '../constant/functions.dart';
import '../constant/strings.dart';
import '../global/refs.dart';
import '../global/ui.dart';
import '../main.dart';
import '../notification_services.dart';
import '../views/Dashboard/Home/HomeScreen.dart';
import '../views/My_Vehicles/selectvehicle.dart';
import '../views/Registration_Screens/Create_Profile.dart';

final UserController controller = Get.find();
final FirebaseAuth auth = FirebaseAuth.instance;

setupCache(String userid) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(AppStrings.userid, userid);
  prefs.setBool(AppStrings.auth, true);
}

clearCache() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(AppStrings.userid, '');
  prefs.setBool(AppStrings.auth, false);
}

logout({bool google = false, bool facebook = false}) async {
  if (google) GoogleSignIn().signOut();
  if (facebook) await FirebaseAuth.instance.signOut();
  // if(controller.user.f)
  auth.signOut();
  clearCache();
  controller.logout();
}

Future<bool> checkUserLogin() async {
  User? user = await FirebaseAuth.instance.currentUser;

  if (user != null) {
    // User is logged in
    print('User is logged in: ${user.phoneNumber}');
    return true;
  } else {
    // No user is logged in
    print('No user is logged in');
    return false;
  }
}

login(String email, String password, BuildContext context) async {
  try {
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((after) async {
      NotificationServices notificationServices = NotificationServices();
      String devicetoken = await notificationServices.getDeviceToken();
      // print("sadsa    d   ${devicetoken}");
      await customersRef
          .doc(after.user!.uid)
          .update({'devicetoken': devicetoken});
      await customersRef.doc(after.user!.uid).get().then((value) async {
        if (value.data() != null) {
          controller.user.value = CustomerModel.fromMap(value.data());
          print(controller.user.value.password);
          print("password = ${password}");
          String pass = XorCipher().encryptData(password, AppStrings.xorkey);

          if (controller.user.value.password != pass) {
            print("if");
            // NotificationServices notificationServices = NotificationServices();
            // String devicetoken = await notificationServices.getDeviceToken();
            // print(devicetoken);
            await customersRef.doc(after.user!.uid).update({
              'password': XorCipher().encryptData(password, AppStrings.xorkey),
              // 'devicetoken': devicetoken
            });
          }
          controller.user.value.password = XorCipher().encryptData(
            password,
            AppStrings.xorkey,
          );
          await setupCache(after.user!.uid);
          controller.login.value = true;
          await controller.getUserDetails(
            after.user!.uid,
            password: password,
            isAuth: true,
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Homescreen()));
        } else {
          Navigator.pop(context);
          auth.signOut();
          Get.showSnackbar(
            Ui.SuccessSnackBar(
              message:
                  'Looks like you are not an authorized user for this application.'
                  ' Please try again with different credentials.',
            ),
          );
        }
      });
    });
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);

    Get.showSnackbar(Ui.ErrorSnackBar(message: formatError(e)));
  } catch (e) {
    Navigator.pop(context);

    Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please try again later.'));
  }
}

loginwithphone(String phone, String password, BuildContext context) async {
  try {
    NotificationServices notificationServices = NotificationServices();
    print(phone);
    print(password);

    CustomerModel? userData = await getUserDataByPhone(phone);
    print("user data= ${userData}");
    if (userData != null) {
      // User found, use userData
      print('User data: ${userData.toMap()}');
      print("password = ${password}");
      String passecrpt = XorCipher().encryptData(password, AppStrings.xorkey);
      print("userData.password = ${userData.password}");

      print("passecrpt = ${passecrpt}");
      print(userData.password == passecrpt);
      if (userData.password == passecrpt) {
        print("if");
        try {
          controller.user.value = CustomerModel.fromMap(userData.toMap());
        } catch (e) {
          print('eeee $e');
        }
        print('User data controller.user.value: ${controller.user.value}');

        String devicetoken = await notificationServices.getDeviceToken();
        await customersRef
            .doc(userData.id)
            .update({'devicetoken': devicetoken});

        await setupCache(userData.id.toString());
        controller.login.value = true;
        await controller.getUserDetails(
          userData.id.toString(),
          password: password,
          isAuth: true,
        );
        CustomEasyLoading.dismiss();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SelectVehicleScreen()),
          (route) => false,
        );
      } else if (userData.password != passecrpt) {
        CustomEasyLoading.dismiss();

        ToastWidget.showToast("Invalid Password");
      }
    } else {
      CustomEasyLoading.dismiss();

      ToastWidget.showToast("User Not Exist");
    }
  } on FirebaseAuthException catch (e) {
    // Navigator.pop(context);
    CustomEasyLoading.dismiss();

    ToastWidget.showToast("${formatError(e)}");

    // Get.showSnackbar(Ui.ErrorSnackBar(message: formatError(e)));
  } catch (e) {
    // Navigator.pop(context);
    CustomEasyLoading.dismiss();

    ToastWidget.showToast("Please try again later.");

    // Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please try again later.'));
  }
}

Future<CustomerModel?> getUserDataByPhone(String phone) async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await customersRef.where('phone', isEqualTo: phone).get();

  if (querySnapshot.docs.isNotEmpty) {
    // User found, return user data
    print("User found");
    return CustomerModel.fromMap(querySnapshot.docs.first.data());
  } else {
    // User not found
    ToastWidget.showToast("User Not Exist");

    return null;
  }
}
// Future<String?> getUserIdByPhone(String phone) async {
//   QuerySnapshot<Map<String, dynamic>> querySnapshot =
//       await customersRef.where('phone', isEqualTo: phone).get();

//   if (querySnapshot.docs.isNotEmpty) {
//     // User found, return user data
//     print("User found");
//     return querySnapshot.docs.first.data()['id'];
//   } else {
//     // User not found
//     ToastWidget.showToast("User Not Exist");

//     return null;
//   }
// }

register(CustomerModel customer, BuildContext context) async {
  try {
    await auth
        .createUserWithEmailAndPassword(
            email: customer.email!, password: customer.password!)
        .then((after) async {
      customer.id = after.user!.uid;
      customer.password = XorCipher().encryptData(
        customer.password!,
        AppStrings.xorkey,
      );
      await customersRef.doc(customer.id).set(customer.toMap());
      Navigator.pop(context);

      Get.showSnackbar(
          Ui.SuccessSnackBar(message: 'User Created Successfully.'));
      // await setupCache(customer.id!);
      // // controller.login.value = true;
      // // await controller.getUserDetails(customer.id!);
    });
  } on FirebaseAuthException catch (e) {
    // Get.back();
    Get.showSnackbar(Ui.ErrorSnackBar(message: formatError(e)));
  } catch (e) {
    // Get.back();
    Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please try again later.${e}'));
  }
}

userregister(CustomerModel customer, BuildContext context) async {
  try {
    // Firebase write operation

    String customerId = auth.currentUser!.uid;
    DocumentSnapshot customerSnapshot =
        await customersRef.doc(customerId).get();

    if (customerSnapshot.exists) {
      // Document already exists, you can update it or handle it as needed
      try {
        controller.user.value = CustomerModel.fromMap(customer.toMap());
        print(" controller.user.value ${controller.user.value}");
      } catch (e) {
        print('eeee $e');
      }
      await setupCache(customerId);
      controller.login.value = true;
      await controller.getUserDetails(
        customerId,
        // password: password,
        isAuth: true,
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homescreen()));
      print('Document already exists: ${customerSnapshot.data()}');
    } else {
      try {
        controller.user.value = CustomerModel.fromMap(customer.toMap());
      } catch (e) {
        print('eeee $e');
      }
      // Document doesn't exist, you can save it
      await customersRef.doc(customerId).set(customer.toMap());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Create_Profile()));
      print('Document saved successfully');
    }
  } catch (e) {
    // Handle Firebase error
    print("Firebase error: $e");
  }
}
