import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/global/refs.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Registration_Screens/Create_Profile.dart';
import 'package:mobile_octane/views/Registration_Screens/Sign_In.dart';
import 'package:pin_code_fields/pin_code_fields.dart'; // Import the OTP input package
import 'package:xor_encryption/xor_encryption.dart';
import '../../AuthenticationService/AuthenticationService.dart';
import '../../Controller/auth_controller.dart';
import '../../Model/customer_model.dart';
import '../../Widgets/shimmer.dart';
import '../../backend/auth.dart';
import '../../constant/strings.dart';
import '../../main.dart';
import '../../main3.dart';
import '../../notification_services.dart';
import '../../services/services/user_services.dart';
import '../Constrants/Colors.dart';
import '../Dashboard/Setting/ForgetpasswordScreen.dart';

class OTPdeleteaccount extends StatefulWidget {
  const OTPdeleteaccount({Key? key}) : super(key: key);

  @override
  State<OTPdeleteaccount> createState() => _OTPdeleteaccountState();
}

class _OTPdeleteaccountState extends State<OTPdeleteaccount> {
  // AuthController _authController = Get.find<AuthController>();

  // late List<FocusNode> _focusNodes;
  // late List<TextEditingController> _controllers;
  late Timer _timer;
  int _timerSeconds = 60;
  String currenttext = "";

  // _OTPdeleteaccountState() {
  //   _focusNodes = List.generate(6, (index) => FocusNode());
  //   _controllers = List.generate(6, (index) => TextEditingController());
  // }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        _timer.cancel();
        // Handle timer completion, e.g., show a "Resend" button
      }
    });
  }

  String getFormattedTimer() {
    int minutes = _timerSeconds ~/ 60;
    int seconds = _timerSeconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    _timer.cancel();
    // for (var controller in _controllers) {
    //   controller.dispose();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            RedText(
              "Forget Password",
              color: AppColors.burColor,
            ),
            SizedBox(height: 10.h),
            Text(
              "Verify Your Identity with One-Time Password",
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 60.h),

            // Use the PinCodeTextField from the pin_code_fields package
            PinCodeTextField(
              appContext: context,
              length: 6,
              autoFocus: true,
              keyboardType: TextInputType.number,
              cursorColor: AppColors.textColor,
              textStyle: GoogleFonts.nunito(fontSize: 18.sp),
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10.0),
                fieldHeight: 50,
                fieldWidth: 45,
                activeFillColor: Colors.transparent,
                inactiveFillColor: Colors.transparent,
                selectedFillColor: Colors.transparent,
                borderWidth: 5,
                activeColor: AppColors.Button1,
                selectedColor: AppColors.Button1,
                inactiveColor: Colors.black12,
                disabledColor: Colors.black12,
              ),
              onChanged: (value) {
                // Handle OTP input changes
                print("otp = ${value}");
                currenttext = value;
              },
            ),

            SizedBox(height: 55.h),
            _timerSeconds > 0
                ? Text(
                    // "00:$_timerSeconds",
                    getFormattedTimer(),
                    style: GoogleFonts.nunito(
                      color: Colors.green,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      authService.sendotpagain(context);
                    },
                    child: Text(
                      "Send again",
                      style: GoogleFonts.nunito(
                        color: Colors.grey,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
            SizedBox(
              height: 200.h,
            ),

            CustomElevatedButton(
              text: "CONFIRM",
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              onPressed: () async {
                print("${currenttext}");
                NotificationServices notificationServices =
                    NotificationServices();
                String devicetoken =
                    await notificationServices.getDeviceToken();

                authService.smsCode =
                    "${currenttext}"; // Replace with the actual phone number

                CustomEasyLoading.show();
                print('verificationId =  ${authService.verificationId}');

                authService.signInWithOTP().then((value) async {
                  print("value=${value}");
                  if (value == true) {
                    if (authService.Forgetpass == true) {
                      CustomEasyLoading.dismiss();
                      // print("delete successfully");
                      // deleteAccount(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword()));
                    } else {
                      CustomEasyLoading.dismiss();
                    }
                  }
                });
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Create_Profile(),
                //   ),
                // );
              },
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> deleteAccount(BuildContext context) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    CustomEasyLoading.show();
    if (user != null) {
      // Delete the user document in Firestore

      await customersRef.doc(user.uid).delete();

      // Delete the user account in Firebase Authentication
      await user.delete();
      await logout(
        google: Get.find<UserServices>().google,
      );
      CustomEasyLoading.dismiss();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Sign_In()),
        (route) => false,
      );

      // If you reach here, the account deletion was successful
      print("Account deleted successfully");
    } else {
      // Handle the case where there is no signed-in user
      print("No signed-in user found");
    }
  } catch (e) {
    // Handle errors here
    print("Error deleting account: $e");
  }
}
