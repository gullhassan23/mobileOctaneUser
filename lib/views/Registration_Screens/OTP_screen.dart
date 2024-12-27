import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/global/refs.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Registration_Screens/Create_Profile.dart';
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
import '../Constrants/Colors.dart';
import '../Dashboard/Setting/ForgetpasswordScreen.dart';

class OTPscreen extends StatefulWidget {
  const OTPscreen({Key? key}) : super(key: key);

  @override
  State<OTPscreen> createState() => _OTPscreenState();
}

class _OTPscreenState extends State<OTPscreen> {
  AuthController _authController = Get.find<AuthController>();

  // late List<FocusNode> _focusNodes;
  // late List<TextEditingController> _controllers;
  late Timer _timer;
  int _timerSeconds = 60;
  String currenttext = "";

  // _OTPscreenState() {
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
              "OTP",
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
                print("password = ${_authController.confirmpasswordcon.text}");
                print("phoneNumber = ${_authController.phoneNumbercon.text}");
                CustomEasyLoading.show();
                print('verificationId =  ${authService.verificationId}');

                authService.signInWithOTP().then((value) async {
                  print("value=${value}");
                  if (value == true) {
                    if (authService.Forgetpass == true) {
                      CustomEasyLoading.dismiss();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword()));
                    } else {
                      String pass = XorCipher().encryptData(
                          _authController.passwordcon.text, AppStrings.xorkey);

                      await userregister(
                          CustomerModel(
                              id: auth.currentUser!.uid,
                              name: "",
                              email: "",
                              password: pass,
                              apple: false,
                              google: false,
                              phone: authService.phoneNumber,
                              created: DateTime.now(),
                              devicetoken: devicetoken),
                          context);
                          _authController.confirmpasswordcon.clear();
                          _authController.passwordcon.clear();
                          _authController.phoneNumbercon.clear();

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
