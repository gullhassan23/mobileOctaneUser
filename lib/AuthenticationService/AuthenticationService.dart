import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_octane/global/refs.dart';
import 'package:mobile_octane/views/Dashboard/Home/HomeScreen.dart';
import '../Model/customer_model.dart';
import '../Widgets/shimmer.dart';
import '../Widgets/toast.dart';
import '../backend/auth.dart';
import '../constant/functions.dart';
import '../global/ui.dart';
import '../main.dart';
import '../notification_services.dart';
import '../views/Constrants/Colors.dart';
import '../views/DeleteAccount/OTPdeleteAccount.dart';
import '../views/My_Vehicles/selectvehicle.dart';
import '../views/Registration_Screens/OTP_screen.dart';

class AuthenticationService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String phoneNumber = '';
  String verificationId = '';
  String smsCode = '';
  bool Forgetpass = false;
  bool deleteaccount = false;

  void checkdata() async {
    print("phoneNumber = ${phoneNumber}");
    print("verificationId = ${verificationId}");
    print("smsCode = ${smsCode}");
  }
Future<bool> isNumberInCollection(String phoneNumber) async {
  try {
    QuerySnapshot querySnapshot = await customersRef
        .where('phone', isEqualTo: phoneNumber)
        .get();

    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    print("Error checking number in collection: $e");
    return false;
  }
}
  Future<bool> signInWithPhoneNumber(BuildContext context) async {
    bool otpsend = false;
    CustomEasyLoading.show();
    Completer<bool> completer = Completer<bool>();
    print("phoneNumber signin =${phoneNumber}");

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await _auth.signInWithCredential(credential);
          otpsend = true;
          CustomEasyLoading.dismiss();

          print('Verification Completed');
          completer.complete(otpsend);
        },
        verificationFailed: (FirebaseAuthException e) {
          CustomEasyLoading.dismiss();

          print('Verification Failed: $e');
          Get.showSnackbar(
              Ui.ErrorSnackBar(message: 'Please try again later.${e}'));
        },
        codeSent: (String verification, int? resendToken) {
          // setState(() {
          otpsend = true;

          verificationId = verification;
          print('Code Sent to $phoneNumber ${otpsend}');

          print('verificationId =  ${verificationId}');
          CustomEasyLoading.dismiss();
          if (Forgetpass == true) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OTPdeleteaccount()));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => OTPscreen()));
          }
          // });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Auto Retrieval Timeout');
          CustomEasyLoading.dismiss();
        },
      );
    } catch (e) {
      print('Error: $e');
      completer.completeError(e);
      CustomEasyLoading.dismiss();
      String errorMessage = 'An error occurred.';

      if (e is FirebaseAuthException) {
        errorMessage = formatError(e);
      }

      // Use the ToastWidget or any other method to display the error message
      ToastWidget.showToast(errorMessage);

      Get.showSnackbar(
          Ui.ErrorSnackBar(message: 'Please try again later.${e}'));
    }
    print("before return = ${otpsend}");

    return otpsend;
  }

  Future<bool> sendotpagain(BuildContext context) async {
    bool otpsend = false;
    CustomEasyLoading.show();
    Completer<bool> completer = Completer<bool>();
    print("phoneNumber signin =${phoneNumber}");

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await _auth.signInWithCredential(credential);
          otpsend = true;
          CustomEasyLoading.dismiss();

          print('Verification Completed');
          completer.complete(otpsend);
        },
        verificationFailed: (FirebaseAuthException e) {
          CustomEasyLoading.dismiss();

          print('Verification Failed: $e');
          Get.showSnackbar(
              Ui.ErrorSnackBar(message: 'Please try again later.${e}'));
        },
        codeSent: (String verification, int? resendToken) {
          // setState(() {
          otpsend = true;

          verificationId = verification;
          print('Code Sent to $phoneNumber ${otpsend}');

          print('verificationId =  ${verificationId}');
          CustomEasyLoading.dismiss();

          // });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Auto Retrieval Timeout');
          CustomEasyLoading.dismiss();
        },
      );
    } catch (e) {
      print('Error: $e');
      completer.completeError(e);
      CustomEasyLoading.dismiss();
      String errorMessage = 'An error occurred.';

      if (e is FirebaseAuthException) {
        errorMessage = formatError(e);
      }

      // Use the ToastWidget or any other method to display the error message
      ToastWidget.showToast(errorMessage);

      Get.showSnackbar(
          Ui.ErrorSnackBar(message: 'Please try again later.${e}'));
    }
    print("before return = ${otpsend}");

    return otpsend;
  }

  Future<bool> signInWithOTP() async {
    bool otpverify = false;

    try {
      print("verification = ${verificationId}");
      print("smsCode = ${smsCode}");

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);
      otpverify = true;
      print('Verification Successful');
    } catch (e) {
      print('Error: $e');
      String errorMessage = 'An error occurred.';
      CustomEasyLoading.dismiss();

      if (e is FirebaseAuthException) {
        errorMessage = formatError(e);
      }

      // Use the ToastWidget or any other method to display the error message
      ToastWidget.showToast(errorMessage);
      // Get.showSnackbar(
      //     Ui.ErrorSnackBar(message: 'Please try again later.${e}'));
      otpverify = false;
    }
    return otpverify;
  }

  GoogleSignIn googleSignInAndroid = GoogleSignIn();

  Future<UserCredential?> signInWithGoogleAndroid(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignInAndroid.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Failed'),
            content: Text('Error signing in with Google: $e'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return null;
    }
  }

  // Future<void> addGoogleDataToFirestoreAndroid(
  //     User user, BuildContext context) async {
  //   try {
  //     NotificationServices notificationServices = NotificationServices();
  //     String devicetoken = await notificationServices.getDeviceToken();

  //     final userDoc = await customersRef.doc(user.uid).get();
  //     if (userDoc.exists) {
  //       controller.user.value = CustomerModel.fromMap(userDoc);
  //       print('Data already exists in Firestore. Skipping update.');
  //     } else {
  //       await userregister(
  //           CustomerModel(
  //               id: user.uid,
  //               name: user.displayName,
  //               email: user.email,
  //               password: "",
  //               apple: false,
  //               google: true,
  //               facebook: false,
  //               phone: authService.phoneNumber,
  //               created: DateTime.now(),
  //               devicetoken: devicetoken),
  //           context);

  //       print('Data added to Firestore');
  //     }
  //   } catch (e) {
  //     print('Error adding/updating data in Firestore: $e');
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return CupertinoAlertDialog(
  //           title: Text('Failed'),
  //           content: Text('Error adding data in Firestore: $e'),
  //           actions: <Widget>[
  //             CupertinoDialogAction(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  Future<void> handleGoogleSignInAndroid(BuildContext context) async {
    final UserCredential? userCredential =
        await signInWithGoogleAndroid(context);
    CustomEasyLoading.dismiss();

    if (userCredential != null) {
      final user = userCredential.user;
      CustomEasyLoading.show();

      NotificationServices notificationServices = NotificationServices();
      String devicetoken = await notificationServices.getDeviceToken();
      DocumentSnapshot customerSnapshot =
          await customersRef.doc(user!.uid).get();
      if (customerSnapshot.exists) {
        controller.login.value = true;

        await setupCache(user!.uid);
        controller.login.value = true;
        await customersRef.doc(user!.uid).update({"devicetoken": devicetoken});
        await controller.getUserDetails(
          user!.uid,
          // password: password,
          isAuth: true,
        );
        CustomEasyLoading.dismiss();

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SelectVehicleScreen()));
      } else {
        await userregister(
            CustomerModel(
                id: user!.uid,
                name: user.displayName,
                email: user.email,
                password: "",
                apple: false,
                google: true,
                facebook: false,
                phone: authService.phoneNumber,
                created: DateTime.now(),
                devicetoken: devicetoken),
            context);
        await setupCache(user!.uid);
        controller.login.value = true;
        await controller.getUserDetails(
          user!.uid,
          // password: password,
          isAuth: true,
        );
        await setupCache(user!.uid);
        controller.login.value = true;
        CustomEasyLoading.dismiss();

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SelectVehicleScreen()));
      }

      Get.snackbar(
        "Success",
        "Logged in with Google successfully.",
        backgroundColor: AppColors.burColor, // Use a static color
        colorText: Colors.white,
      );

      // await addGoogleDataToFirestoreAndroid(user!, context);

      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => Homescreen()));
    }
  }

  GoogleSignIn googleSignInApple = GoogleSignIn(
    clientId:
        "326799183524-kpmgggf0gt5imjp8810s11g905gq8c3t.apps.googleusercontent.com",
  );

  Future<UserCredential?> signInWithGoogleApple(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignInApple.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Failed'),
            content: Text('Error signing in with Google: $e'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return null;
    }
  }

  Future<void> addGoogleDataToFirestoreApple(
      User user, BuildContext context) async {
    try {
      NotificationServices notificationServices = NotificationServices();
      String devicetoken = await notificationServices.getDeviceToken();
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('Customer');
      final userDoc = await usersCollection.doc(user.uid).get();
      if (userDoc.exists) {
        print('Data already exists in Firestore. Skipping update.');
      } else {
        // await usersCollection.doc(user.uid).set({
        //   "id": user.uid,
        //   "name": user.displayName,
        //   "email": user.email,
        //   "password": "",
        //   "apple": false,
        //   "google": true,
        //   "phone": user.phoneNumber ?? "",
        //   devicetoken: devicetoken
        // });
        await userregister(
            CustomerModel(
                id: user.uid,
                name: user.displayName,
                email: user.email,
                password: "",
                apple: false,
                google: true,
                facebook: false,
                created: DateTime.now(),
                phone: authService.phoneNumber,
                devicetoken: devicetoken),
            context);

        print('Data added to Firestore');
      }
    } catch (e) {
      print('Error adding/updating data in Firestore: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Failed'),
            content: Text('Error adding data in Firestore: $e'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> handleGoogleSignInApple(BuildContext context) async {
    final UserCredential? userCredential = await signInWithGoogleApple(context);
    if (userCredential != null) {
      final user = userCredential.user;

      Get.snackbar(
        "Success",
        "Logged in with Google successfully.",
        backgroundColor: AppColors.burColor, // Use a static color
        colorText: Colors.white,
      );

      await addGoogleDataToFirestoreApple(user!, context);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homescreen()));
    }
  }

  Future<UserCredential?> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: ['public_profile']);

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        return userCredential;
      } else if (result.status == LoginStatus.cancelled) {
        print('Facebook login cancelled');
      } else {
        print('Error logging in with Facebook');
      }
    } catch (e) {
      print('Error signing in with Facebook: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Failed'),
            content: Text('Error signing in with Facebook: $e'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return null;
  }

  Future<void> addFacebookDataToFirestore(
      User user, BuildContext context) async {
    try {
      NotificationServices notificationServices = NotificationServices();
      String devicetoken = await notificationServices.getDeviceToken();
      final usersCollection = FirebaseFirestore.instance.collection('Customer');
      final userDoc = await usersCollection.doc(user.uid).get();

      if (userDoc.exists) {
        print('Data already exists in Firestore. Skipping update.');
      } else {
        // await usersCollection.doc(user.uid).set({
        //   "id": user.uid,
        //   "name": user.displayName,
        //   "email": user.email,
        //   "password": "",
        //   "apple": false,
        //   "facebook": true,
        //   "google": false,
        //   "phone": user.phoneNumber ?? "",
        //   devicetoken: devicetoken
        // });
        await userregister(
            CustomerModel(
                id: user.uid,
                name: user.displayName,
                email: user.email,
                password: "",
                apple: false,
                google: false,
                facebook: true,
                phone: authService.phoneNumber,
                devicetoken: devicetoken),
            context);

        print('Data added to Firestore');
      }
    } catch (e) {
      print('Error adding/updating data in Firestore: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Failed'),
            content: Text('Error adding/updating data in Firestore: $e'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> handleFacebookSignIn(BuildContext context) async {
    final UserCredential? userCredential = await signInWithFacebook(context);
    if (userCredential != null) {
      final user = userCredential.user;
      Get.snackbar(
        "Success",
        "Logged in with Facebook successfully.",
        backgroundColor: AppColors.burColor, // Use a static color
        colorText: Colors.white,
      );
      CustomEasyLoading.show();

      NotificationServices notificationServices = NotificationServices();
      String devicetoken = await notificationServices.getDeviceToken();
      DocumentSnapshot customerSnapshot =
          await customersRef.doc(user!.uid).get();
      if (customerSnapshot.exists) {
        controller.login.value = true;

        await setupCache(user!.uid);
        controller.login.value = true;
        await customersRef.doc(user!.uid).update({"devicetoken": devicetoken});
        await controller.getUserDetails(
          user!.uid,
          // password: password,
          isAuth: true,
        );
        CustomEasyLoading.dismiss();

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SelectVehicleScreen()));

        // await addFacebookDataToFirestore(user!, context);

        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => Homescreen()));
      }else {
        await userregister(
            CustomerModel(
                id: user!.uid,
                name: user.displayName,
                email: user.email,
                password: "",
                apple: false,
                google: false,
                facebook: true,
                phone: authService.phoneNumber,
                created: DateTime.now(),
                devicetoken: devicetoken),
            context);
        await setupCache(user!.uid);
        controller.login.value = true;
        await controller.getUserDetails(
          user!.uid,
          // password: password,
          isAuth: true,
        );
        await setupCache(user!.uid);
        controller.login.value = true;
        CustomEasyLoading.dismiss();

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SelectVehicleScreen()));
      }

    }
  }
}
