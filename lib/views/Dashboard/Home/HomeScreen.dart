import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/global/refs.dart';
import 'package:mobile_octane/services/services/user_services.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Dashboard/Home/Fill_Up/Fill_Up_1.dart';
import 'package:mobile_octane/views/Dashboard/Setting/settings.dart' as setting;
import 'package:mobile_octane/views/Notification.dart';

// import '../../../Model/FuelUp_model.dart';
import '../../../Model/FuelUp_model.dart';
import '../../../Widgets/purchasehistorywidget.dart';
import '../../../binding/addfuelbinding.dart';
import '../../Receipt/reciept.dart';
import '../../TERMS/PurchaseHistory.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with WidgetsBindingObserver {
  UserServices _userServices = Get.find<UserServices>();
  late Timer _timer;
  late CollectionReference locations;
      final service = FlutterBackgroundService();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addObserver(this);

    // backgroundservicecontrol();
     _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      saveLocationToFirestore();
    });

    // _startLocationUpdates();
    super.initState();
  }

  
Future<void> saveLocationToFirestore() async {
  // Permission granted, proceed to get the current location
 
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(position);
    print(Get.find<UserServices>().customer.id);
    // Update Firestore with the location
    customersRef.doc(Get.find<UserServices>().customer.id).update({
      'latitude': position.latitude,
      'longitude': position.longitude,
      // 'timestamp': FieldValue.serverTimestamp(),
    }).then((value) {
      print("Location saved to Firestore: ${position.latitude}, ${position.longitude}");
    }).catchError((error) {
      print("Error saving location: $error");
    });

}

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    print("state = ${state}");
    if (state == AppLifecycleState.detached) {
      print("state stop");
      // backgroundservicecontrol();

      service.invoke("stopService");
    }
  }

  Future<void> backgroundservicecontrol() async {
    final service = FlutterBackgroundService();

    service.startService();
  }

  @override
  void dispose() {
  if (_timer.isActive) {
      _timer.cancel();
    }
    WidgetsBinding.instance?.removeObserver(this);
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.h,
              top: 40.h,
              right: 10.h,
            ),
            child: Row(
              children: [
                InkWell(
                  splashColor: Colors
                      .transparent, // Optional: Set splashColor to transparent
                  highlightColor: Colors
                      .transparent, // Optional: Set highlightColor to transparent
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => setting.Settings()));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 29.r,
                        backgroundColor: AppColors.burColor,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      SizedBox(width: 5.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome Back!",
                              style: GoogleFonts.nunito(
                                  color: Colors.black54, fontSize: 14.sp)),
                          Obx(
                            () => Text("${_userServices.customer.name}",
                                style: GoogleFonts.nunito(
                                    color: AppColors.textColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PurchaseHistory()));
                  },
                  child: Container(
                    height: 20.h,
                    width: 20.w,
                    child: Image.asset(
                      "assets/img_notification_3.png",
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()));
                  },
                  child: Container(
                    height: 20.h,
                    width: 20.w,
                    child: Image.asset(
                      "assets/img_notification_20x20.png",
                      color: AppColors.textColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.black,
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 250.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/img_rectangle_148265.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20.r),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r)),
                    color: AppColors.backgroundColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 15.w, right: 15.w, bottom: 0.h, top: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RedText(
                              "Mobile Octane",
                              color: AppColors.burColor,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/img_time_circle.svg",
                                  height: 15.h,
                                  width: 15.w,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 7.h,
                                ),
                                GreyText(
                                  "24/7",
                                  color: AppColors.textColor,
                                  fontsize: 13.sp,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text("Price",
                                style: GoogleFonts.nunito(
                                  fontSize: 15.sp,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                         StreamBuilder(
                          stream: fuelRef.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.Button1,
                                ),
                              );
                            }
                            if (snapshot.hasData) {
                              // Data is ready
                              var fuels = snapshot.data?.docs ?? [];
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: fuels.length,
                                itemBuilder: (context, index) {
                                  var fuelData = fuels[index].data()
                                      as Map<String, dynamic>;
                                  print(fuelData);

                                  // Use fuelData to build your UI components
                                  return Text(
                                    "${fuelData['name']} : \$${fuelData['PricePerLiter']} /L ",
                                    style: GoogleFonts.nunito(
                                      fontSize: 16.sp,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.6,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("My Recent Order ",
                                style: GoogleFonts.nunito(
                                    fontSize: 16.sp,
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: -0.2)),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PurchaseHistory()));
                              },
                              child: Text("See All",
                                  style: GoogleFonts.nunito(
                                      fontSize: 13.sp,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: -0.6)),
                            ),
                          ],
                        ),
                        Expanded(
                          child: StreamBuilder<
                              Map<String, List<DocumentSnapshot>>>(
                            stream: fuelTransaction
                                .doc(_userServices.customer.id)
                                .collection("Transaction")
                                .orderBy("createdAt", descending: true)
                                .limit(1)
                                .snapshots()
                                .map((querySnapshot) {
                              Map<String, List<DocumentSnapshot>> groupedData =
                                  {};

                              querySnapshot.docs.forEach((document) {
                                DateTime createdAt =
                                    (document['createdAt'] as Timestamp)
                                        .toDate();
                                String formattedDate =
                                    "${createdAt.day}-${createdAt.month}-${createdAt.year}";

                                if (!groupedData.containsKey(formattedDate)) {
                                  groupedData[formattedDate] = [];
                                }
                                groupedData[formattedDate]!.add(document);
                              });

                              return groupedData;
                            }),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.Button1,
                                ));
                              }
                              if (snapshot.data!.isEmpty) {
                                return Center(
                                  child: SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Data Not Found",
                                          style: GoogleFonts.nunito(
                                              fontSize: 16.sp,
                                              color: AppColors.textColor,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: -0.2)),
                                    ),
                                  ),
                                );
                              }
                              Map<String, List<DocumentSnapshot>>? groupedData =
                                  snapshot.data;

                              if (snapshot.hasData) {
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: groupedData!.length,
                                  itemBuilder: (context, index) {
                                    String date =
                                        groupedData.keys.elementAt(index);
                                    List<DocumentSnapshot> transactions =
                                        groupedData[date]!;
                                    DateTime currentDate = DateTime.now();
                                    String currentDateString =
                                        "${currentDate.day}-${currentDate.month}-${currentDate.year}";
                                    DateTime previousDate =
                                        currentDate.subtract(Duration(days: 1));

                                    String previousDateString =
                                        "${previousDate.day}-${previousDate.month}-${previousDate.year}";

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          date == currentDateString
                                              ? "Today"
                                              : date == previousDateString
                                                  ? "Tomorrow"
                                                  : "$date",
                                          style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                              color: AppColors.textColor),
                                        ),
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: transactions.length,
                                          itemBuilder: (context, index) {
                                            // Display individual transactions here
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    surfaceTintColor:
                                                        Colors.transparent,
                                                    backgroundColor:
                                                        Color(0XFFF4F5F7),
                                                    // primary: Color(0XFFF4F5F7),
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13.h),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TransactionReceiptDetailPage(
                                                                  detail:
                                                                      transactions[
                                                                          index],
                                                                )));
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.h,
                                                        right: 10.w,
                                                        left: 10.w,
                                                        bottom: 10.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${double.parse(transactions[index]['price'].toString()).toStringAsFixed(2)} fill up",
                                                          style: GoogleFonts.nunito(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15.sp,
                                                              color: AppColors
                                                                  .textColor),
                                                        ),
                                                        Text(
                                                          "${transactions[index]['fuel']['name'].toString()}",
                                                          style: GoogleFonts
                                                              .nunito(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      15.sp,
                                                                  color: AppColors
                                                                      .burColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                // PurchaseHistoryWidget(
                                                //     title:
                                                //         "${double.parse(transactions[index]['price'].toString()).toStringAsFixed(2)} fill up",
                                                //     smalltitle:
                                                //         "${transactions[index]['fuel']['name'].toString()}"),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                              return Container();
                            },
                          ),
                        ),
                        CustomElevatedButton(
                            text: "FILL ME UP",
                            onPressed: () {
                              Navigator.push(
                                context,
                                GetPageRoute(
                                    page: () => Fill_Up_1(),
                                    binding: AddFuelBinding()),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
