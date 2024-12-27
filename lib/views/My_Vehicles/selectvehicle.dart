import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Controller/user_controller.dart';
import 'package:mobile_octane/Model/vehicle_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mobile_octane/Widgets/toast.dart';
import 'package:mobile_octane/backend/auth.dart';
import 'package:mobile_octane/main3.dart';
import '../../Controller/addfuelController.dart';
import '../../Model/notificationmodel.dart';
import '../../Widgets/Buttons.dart';
import '../../Widgets/CustomImageView.dart';
import '../../Widgets/custom_radio_button.dart';
import '../../Widgets/shimmer.dart';
import '../../global/refs.dart';
import '../../main.dart';
import '../../services/services/user_services.dart';
import '../../stripe_payment/stripescreen.dart';
import '../Constrants/Colors.dart';
import '../Constrants/Font.dart';
import '../Dashboard/Home/HomeScreen.dart';
import '../PaymentSuccessScreen/payment_success_screen.dart';
import '../Registration_Screens/Add_Vechile/Add_Vehicle.dart';

class SelectVehicleScreen extends StatefulWidget {
  const SelectVehicleScreen({super.key});

  @override
  State<SelectVehicleScreen> createState() => _SelectVehicleScreenState();
}

class _SelectVehicleScreenState extends State<SelectVehicleScreen> {
  String? selectedVehicle;
  UserServices _userServices = Get.find<UserServices>();
  UserController _userController = Get.find<UserController>();

  VehicleDetails? selectedVehicledetail;
  int maxVehicleLimit = 3;
  int vehiclelenght = 0;
  String userId = "";
  bool islogin = false;
  @override
  void initState() {
    // TODO: implement initState
    _delayedExecution();
    super.initState();
  }

  Future<void> _delayedExecution() async {
    await Future.delayed(Duration(seconds: 3));
    checkUserLogin().then((value) {
      setState(() {
        islogin = value;
        if (value) {
          userId = FirebaseAuth.instance.currentUser!.uid;
        } else {
          userId = _userController.user.value.id.toString();
        }
      });
    });
    print("eeee user id = $userId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 70.h),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eget felis tellus.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    color: Colors.black38,
                    fontSize: 12.sp,
                    // fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400)),
            SizedBox(height: 20.h),
            // Text("userId = ${userId}"),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Text("Select Vehicle",
                        style: GoogleFonts.nunito(
                            // color: appTheme.black900,
                            color: AppColors.textColor,
                            fontSize: 18.sp,
                            // fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600)))),
            // SizedBox(height: 15.h),

            userId == ""
                ? SizedBox(
                    height: 300.h,
                    child: shimmerwidget(
                      height: 50.h,
                    ),
                  )
                : _buildSelectAllColumn(),
            GestureDetector(
              onTap: () {
                // print("vehicle = ${vehiclelenght}");
                // addVehicle();
                if (vehiclelenght < maxVehicleLimit) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Add_Vehicle_screen()),
                  );
                } else {
                  // Show custom popup when the limit is reached
                  showlimitupdailog();
                }
              },
              child: GreyText(
                "Add more Vehicle",
                color: AppColors.textColor,
              ),
            ),

            SizedBox(height: 5.h)
          ]),
        ),
        bottomNavigationBar: _buildNext(context));
  }

  /// Section Widget
  Widget _buildSettingRow(BuildContext context) {
    return SizedBox(
        height: 77.h,
        width: double.maxFinite,
        child: Stack(alignment: Alignment.bottomRight, children: [
          Align(
              alignment: Alignment.center,
              child: Container(
                  width: double.maxFinite,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    CustomImageView(
                        imagePath: "assets/img_mask_group_24x24.png",
                        height: 24.h,
                        width: 24.w,
                        margin: EdgeInsets.only(top: 27.h, bottom: 3.h),
                        onTap: () {
                          // onTapImgImage();
                          Navigator.pop(context);
                        }),
                    Padding(
                        padding: EdgeInsets.only(left: 110.w, top: 26.h),
                        child: Text("Fill Up",
                            style: GoogleFonts.nunito(
                                // color: appTheme.gray90001,
                                fontSize: 20.sp,
                                color: AppColors.burColor,
                                // fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700)))
                  ]))),
        ]));
  }

  /// Section Widget
  Widget _buildSelectAllColumn() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: StreamBuilder<QuerySnapshot>(
            stream: vehicleRef.doc(userId).collection("vehicles").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  // height: 40.h,
                );
              }
              if (snapshot.hasData) {
                var Vehicles = snapshot.data!.docs;
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                List<VehicleDetails> vehicle = documents.map((doc) {
                  return VehicleDetails.fromMap(
                      doc.data() as Map<String, dynamic>);
                }).toList();
                vehiclelenght = vehicle.length;
                if (Vehicles.isNotEmpty) {
                  if (selectedVehicle.toString() == "null") {
                    selectedVehicle = vehicle.first.id;
                    selectedVehicledetail = vehicle.first;
                  }
                }
                print("ffffff ${Vehicles}");
                return ListView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: Vehicles.length,
                  itemBuilder: (context, index) {
                    var Vehicle = Vehicles[index];

                    return Column(
                      children: [
                        InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                selectedVehicle = Vehicle['id'];
                                selectedVehicledetail = vehicle[index];
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 10.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 14.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 2.r,
                                      blurRadius: 2.r,
                                      offset: Offset(
                                        0,
                                        0,
                                      ),
                                    ),
                                  ],
                                ),
                                // decoration: Colors.white
                                //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        height: 18.h,
                                        width: 20.w,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 12.h),
                                        padding: EdgeInsets.all(4.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                            width: 1.h,
                                            color:
                                                selectedVehicle == Vehicle['id']
                                                    ? Color(0XFFE9EAEB)
                                                    : Colors.grey.shade300,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: selectedVehicle == Vehicle['id']
                                            ? CustomImageView(
                                                imagePath:
                                                    "assets/img_mask_group_12x12.png",
                                                height: 12.h,
                                                color: AppColors.textColor,
                                                width: 12.w,
                                                alignment: Alignment.center)
                                            : Container(),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 15.h),
                                          child: _buildViewColumn(
                                              vehicleCount:
                                                  Vehicle['vehiclename'],
                                              licenceNumber:
                                                  "Licence Number: ${Vehicle['licensePlateNumber'].toString()}")),
                                    ]))),
                        SizedBox(height: 20.h),
                      ],
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }

  /// Section Widget
  Widget _buildNext(BuildContext context) {
    return CustomElevatedButton(
        text: "Start".toUpperCase(),
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
        onPressed: () async {
          LocationPermission permission = await Geolocator.checkPermission();

          if (permission == LocationPermission.denied) {
            showPermissionDeniedDialog(context);
          }

          if (permission == LocationPermission.deniedForever) {
            // Handle denied forever
            showPermissionDeniedDialog(context);
          }

          if (permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always) {
            // _getCurrentLocation();
            if (selectedVehicledetail != null) {
              CustomEasyLoading.show();
              selectedVehicledetail = selectedVehicledetail;
              customersRef.doc(_userServices.customer.id).update({
                'currentvehicle': selectedVehicledetail!.id,

                // 'timestamp': FieldValue.serverTimestamp(),
              }).then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Homescreen()));
                CustomEasyLoading.dismiss();

                print(
                    "Location saved to Firestore: ${selectedVehicledetail!.id}");
              }).catchError((error) {
                print("Error saving location: $error");
              });
            } else {
              if (vehiclelenght == 0) {
                ToastWidget.showToast("Please add vehicle");
              } else {
                ToastWidget.showToast("Please select vehicle");
              }
            }
          }
        });
  }

  /// Common widget
  Widget _buildViewColumn({
    required String vehicleCount,
    required String licenceNumber,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(vehicleCount,
          style: GoogleFonts.mulish(
              // color: Color(0XFF5A5A5A),
              color: AppColors.textColor,
              fontSize: 15.sp,
              // fontFamily: 'Mulish',
              fontWeight: FontWeight.w600)),
      SizedBox(height: 2.h),
      Text(licenceNumber,
          style: GoogleFonts.nunito(
              // color: Color(0XFF525252),
              color: AppColors.textColor,
              fontSize: 11.sp,
              // fontFamily: 'Nunito',
              fontWeight: FontWeight.w400))
    ]);
  }

  Future<dynamic> showlimitupdailog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          content: Container(
            height: 200.h,
            width: 300.w,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img_image_1463.png', // Replace with your image asset path
                  height: 50.h,
                  width: 50.w,
                ),
                SizedBox(height: 16.h),
                Text(
                  "You have reached your limit.",
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 18.sp,
                    // fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Sed diginissim nisl a vehicula fringilla.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 12.sp,
                    // fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "Nulla faucibus dui tellus, ut dingnissim",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 12.sp,
                    // fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the popup
                  },
                  child: Text(
                    "Ok",
                    style: GoogleFonts.nunito(
                      color: Colors.green,
                      fontSize: 14.sp,
                      letterSpacing: -0.7,
                      // fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
