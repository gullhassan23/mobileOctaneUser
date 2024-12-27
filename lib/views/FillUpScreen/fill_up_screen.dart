import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Model/vehicle_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mobile_octane/Widgets/toast.dart';
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
import '../PaymentSuccessScreen/payment_success_screen.dart';

class fill_up_screen extends StatefulWidget {
  const fill_up_screen({super.key});

  @override
  State<fill_up_screen> createState() => _fill_up_screenState();
}

class _fill_up_screenState extends State<fill_up_screen> {
  String? selectedVehicle;
  UserServices _userServices = Get.find<UserServices>();
  AddFuelController _addFuelController = Get.find<AddFuelController>();

  VehicleDetails? selectedVehicledetail;
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(children: [
            _buildSettingRow(context),
            SizedBox(height: 15.h),
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
            _buildSelectAllColumn(),
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
        child: Column(children: [
          // Padding(
          //     padding: EdgeInsets.only(right: 10.h),
          //     child: CustomRadioButton(
          //         text: "Select All",
          //         value: "Select All",
          //         groupValue: "1",
          //         padding: EdgeInsets.fromLTRB(16.w, 14.h, 30.w, 14.h),
          //         onChange: (value) {
          //           // controller.radioGroup.value = value;
          //         })),
          // SizedBox(height: 16.h),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: StreamBuilder<QuerySnapshot>(
              stream: vehicleRef
                  .doc(_userServices.customer.id.toString())
                  .collection("vehicles")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return shimmerwidget(
                    height: 40.h,
                  );
                }
                if (snapshot.hasData) {
                  var Vehicles = snapshot.data!.docs;
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  List<VehicleDetails> vehicle = documents.map((doc) {
                    return VehicleDetails.fromMap(
                        doc.data() as Map<String, dynamic>);
                  }).toList();
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
                                  selectedVehicle = Vehicle['vehiclename'];
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
                                              color: selectedVehicle ==
                                                      Vehicle['vehiclename']
                                                  ? Color(0XFFE9EAEB)
                                                  : Colors.grey.shade300,
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: selectedVehicle ==
                                                  Vehicle['vehiclename']
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
                                            padding:
                                                EdgeInsets.only(left: 15.h),
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
          ),
        ]));
  }

  /// Section Widget
  Widget _buildNext(BuildContext context) {
    return CustomElevatedButton(
        text: "Next".toUpperCase(),
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
        onPressed: () {
          if (selectedVehicledetail != null) {
            _addFuelController.selectedVehicledetail = selectedVehicledetail;

// print(_addFuelController.selectedVehicledetail!.toMap());
            print(_addFuelController.totalprice);
            makePayment();
            // _showNotification();
          } else {
            ToastWidget.showToast("Please select vehicle");
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

  Future<void> makePayment() async {
    CustomEasyLoading.show();
    try {
      paymentIntentData = await createPaymentIntent(
          _addFuelController.totalprice.toString(),
          'usd'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  setupIntentClientSecret: 'Your Secret Key',
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  customFlow: true,
                  style: ThemeMode.dark,
                  merchantDisplayName: 'sds'))
          .then((value) {
        CustomEasyLoading.dismiss();
      });

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('Payment exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        _addFuelController.addfuel();

        _showNotification();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => payment_success_screen()));

        // ScaffoldMessenger.of(context)
        //     .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        // 'amount': amount,

        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ' +
                'sk_test_51LYvOaG5oJVKdCdoSBgJVQY3FtPewAydxJ7k5uWmr2wUu4l9pRlDExp6SjqSpT2Lcdw26a60CEhzwlPANWymF9E700qG7AlO7L',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');

      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    double a = (double.parse(amount));
    int amountInCents = (a * 100).toInt();
    return amountInCents.toString();
  }
}

Future<void> _showNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id', // Replace with your own channel ID
    'your_channel_name', // Replace with your own channel name

    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    1829, // Notification ID
    'Fuel Added', // Notification Title
    'Payment Successfully Pay', // Notification Body
    platformChannelSpecifics,
  );
}



