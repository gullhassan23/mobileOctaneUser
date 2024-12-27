import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Controller/user_controller.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/global/refs.dart';
import 'package:mobile_octane/services/services/user_services.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Profile_Completed/Profile_completed.dart';
import 'package:mobile_octane/views/Registration_Screens/Select_your_Plan2.dart';

import '../../Model/vehicle_model.dart';
import '../../Widgets/shimmer.dart';
import '../../backend/auth.dart';
import '../Registration_Screens/Add_Vechile/Add_Vehicle.dart';

class My_Vehicle extends StatefulWidget {
  bool fromsetting;
  My_Vehicle({required this.fromsetting, super.key});

  @override
  State<My_Vehicle> createState() => _My_VehicleState();
}

class _My_VehicleState extends State<My_Vehicle> {
  UserServices _userServices = Get.find<UserServices>();
  int maxVehicleLimit = 3;

  List<Map<String, String>> vehicles = [
    {"name": "Vehicle 1", "licenseNumber": "86573"},
  ];
  int vehiclelenght = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 229, 203, 1),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(241, 229, 203, 1),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          children: [
            RedText(
              "My Vehicles",
              color: AppColors.burColor,
            ),
            SizedBox(height: 5.h),
            GreyText(
              "You can have more than 1 vehicle",
              maxLines: 2,
              color: AppColors.textColor,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 20.h),
            // Text(_userServices.customer.id.toString()),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: StreamBuilder<QuerySnapshot>(
                stream: vehicleRef
                    .doc(_userServices.customer.id.toString())
                    .collection("vehicles")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return shimmerwidget(height: 65.h);
                  } else if (snapshot.hasData) {
                    var vehicles = snapshot.data!.docs;

                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: vehicles.length,
                      itemBuilder: (context, index) {
                        var vehicle = vehicles[index];
                        var vehicleDetails = VehicleDetails.fromMap(
                            vehicle.data() as Map<String, dynamic>);
                        vehiclelenght = vehicles.length;
                        return Column(
                          children: [
                            buildVehicle(vehicleDetails),
                            SizedBox(
                                height: 20.h), // Adjust the height as needed
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),

            // Column(
            //   children: List.generate(
            //     vehicles.length,
            //     (index) => Column(
            //       children: [
            //         buildVehicleCard(index),
            //         SizedBox(height: 20.h), // Adjust the height as needed
            //       ],
            //     ),
            //   ),
            // ),

            // SizedBox(height: 20.h),
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
            SizedBox(
              height: 100.h,
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.fromsetting == false
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomElevatedButton(
                text: "NEXT",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile_Completed()),
                  );
                },
              ),
            )
          : null,
    );
  }

  Widget buildVehicle(VehicleDetails vehicleDetails) {
    return SizedBox(
      height: 70.h,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        margin: EdgeInsets.all(0),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        vehicleDetails.vehiclename,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        " ${_userServices.customer.currentvehicle == vehicleDetails.id ? "( Selected )" : ""}",
                        style: TextStyle(
                            color: AppColors.Button1,
                            fontSize: 15,
                            // fontWeight: FontWeight.w600,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // Icon(
                  //   Icons.more_vert,
                  //   size: 20,
                  // )
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Colors.black, // Icon color
                    ),
                    onSelected: (value) async {
                      if (value == 'delete') {
                        // Handle delete action

                        await vehicleRef
                            .doc(_userServices.customer.id)
                            .collection("vehicles")
                            .doc(vehicleDetails.id)
                            .delete();

                        // await customersRef
                        //     .doc(_userServices.customer.id)
                        //     .update({
                        //   'currentvehicle': "",

                        //   // 'timestamp': FieldValue.serverTimestamp(),
                        // });
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return ['Delete'].map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice.toLowerCase(),
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
              Text(
                "Licence Number : ${vehicleDetails.licensePlateNumber}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVehicleCard(int index) {
    return SizedBox(
      height: 70.h,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        margin: EdgeInsets.all(0),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vehicles[index]["name"]!,
                    style: GoogleFonts.nunito(
                      color: AppColors.textColor,
                      fontSize: 15.sp,
                      // fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.more_vert,
                    size: 20.sp,
                  )
                ],
              ),
              Text(
                "Licence Number : ${vehicles[index]["licenseNumber"]}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunito(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 11.sp,
                  // fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addVehicle() {
    setState(() {
      if (vehicles.length < 5) {
        int newIndex = vehicles.length + 1;
        vehicles.add({"name": "Vehicle $newIndex", "licenseNumber": "86573"});
      } else {
        // Show custom popup when the limit is reached
        showlimitupdailog();
      }
    });
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
