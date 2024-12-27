import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/views/Dashboard/Home/HomeScreen.dart';
import 'package:mobile_octane/views/On_Bording_screen/onboard_screen.dart';

import '../services/services/user_services.dart';
import 'My_Vehicles/selectvehicle.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // Call the function to navigate after 2 seconds
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Obx(
                    () => Get.find<UserServices>().auth
                        // ? Homescreen()
                        ? SelectVehicleScreen()
                        : Onboarding_Screen(),
                  );
                },
              ),
            ));
    //  Obx(
    //   () => Get.find<UserServices>().auth ?  Homescreen() :  Onboarding_Screen(),
    // );;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo1.png",
              height: 150.h,
              width: 150.w,
            ),
            SizedBox(height: 5.h),
            Text(
              "Mobile Octane",
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
