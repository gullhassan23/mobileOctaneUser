import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Dashboard/Home/HomeScreen.dart';
import 'package:mobile_octane/views/FillUpCompletedScreen/fill_up_completed_screen.dart';

import '../../Controller/addfuelController.dart';
import '../../Widgets/Buttons.dart';
import '../../Widgets/CustomImageView.dart';

class payment_success_screen extends StatefulWidget {
  const payment_success_screen({super.key});

  @override
  State<payment_success_screen> createState() => _payment_success_screenState();
}

class _payment_success_screenState extends State<payment_success_screen> {
  AddFuelController _addFuelController = Get.find<AddFuelController>();
  String formatDate(DateTime date) {
    // Create a date format with the desired pattern
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    // Format the date and return the result
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SizedBox(
            width: double.maxFinite,
            child: Column(children: [
              SizedBox(height: 80.h),
              CustomImageView(
                  imagePath: "assets/img_checkmark.svg",
                  height: 40.h,
                  width: 40.w),
              SizedBox(height: 18.h),
              Text("Payment Success!",
                  style: GoogleFonts.poppins(
                      color: Color(0XFF23A26D),
                      fontSize: 16.sp,
                      // fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 5.h),
              Text("\$${_addFuelController.totalprice.toStringAsFixed(2)}",
                  style: GoogleFonts.poppins(
                      color: Color(0XFF121212),
                      fontSize: 25.sp,
                      // fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 15.h),
              _buildReceiptCardSection(),
              Spacer(),
              SizedBox(height: 50.h),
              GestureDetector(
                  onTap: () {
                    // onTapTxtBackToHome();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Homescreen()));
                  },
                  child: Text("Back to home",
                      style: GoogleFonts.nunito(
                          color: AppColors.burColor,
                          fontSize: 15.sp,
                          // fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700))),
              SizedBox(height: 30.h),
            ])));
  }

  /// Section Widget

  /// Section Widget
  Widget _buildReceiptCardSection() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.all(9.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0X1EAAAAAA),
              spreadRadius: 2.h,
              blurRadius: 2.h,
              offset: Offset(
                0,
                9.04,
              ),
            ),
          ],
        ),
        // decoration: AppDecoration.outlineGrayE
        //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: 60.h,
            width: double.maxFinite,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Color(0XFFF4F5F7),
                  // primary: Color(0XFFF4F5F7),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.h),
                  ),
                ),
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => fill_up_completed_screen()));
                },
                child: Text(
                  "Request Details",
                  style: GoogleFonts.nunito(
                    // color: Colors.black,
                    color: AppColors.textColor,

                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                )),
          ),
          // CustomElevatedButton(
          //     height: 68.h,
          //     text: "Request Details",
          //     buttonStyle: ElevatedButton.styleFrom(
          //       backgroundColor: Color(0XFFF4F5F7),
          //       primary: Color(0XFFF4F5F7),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(13.h),
          //       ),
          //     )),
          SizedBox(height: 15.h),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.h),
              child: _buildPaymentDetailSection(
                  amountText: "Payment Time",
                  priceText:
                      "${formatDate(DateTime.now())}, ${_addFuelController.selectedTime!.hour} : ${_addFuelController.selectedTime!.minute} : 00")),
          SizedBox(height: 10.h),
          Divider(color: Colors.black, indent: 15.h, endIndent: 15.h),
          SizedBox(height: 10.h),
         
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: _buildPaymentDetailSection(
                  amountText: "Fuel Type",
                  priceText: "${_addFuelController.selectedFuel!.name}")),
          SizedBox(height: 10.h),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.h),
              child: _buildPaymentDetailSection(
                  amountText: "Liter",
                  priceText:
                      "${double.parse(_addFuelController.totalliter.toStringAsFixed(2))} L")),
          SizedBox(height: 10.h),
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: _buildPaymentDetailSection(
                  amountText: "Per Liter Price",
                  priceText:
                      "\$${_addFuelController.selectedFuel!.pricePerLiter.toStringAsFixed(2)}")),
          SizedBox(height: 10.h),
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: _buildPaymentDetailSection(
                  amountText: "Amount",
                  priceText:
                      "\$${_addFuelController.totalprice.toStringAsFixed(2)}")),
          SizedBox(height: 10.h),
        ]));
  }

  /// Common widget
  Widget _buildPaymentDetailSection({
    required String amountText,
    required String priceText,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(amountText,
          style: GoogleFonts.poppins(
              color: Color(0XFF6F6F6F),
              fontSize: 11.sp,
              // fontFamily: 'Poppins',
              fontWeight: FontWeight.w400)),
      Text(priceText,
          style: GoogleFonts.poppins(
              // color: Color(0XFF121212),
              color: AppColors.textColor,
              fontSize: 10.695652961730957.sp,
              // fontFamily: 'Poppins',
              fontWeight: FontWeight.w500))
    ]);
  }

  /// Displays a scrollable bottom sheet widget using the [Get] package
  /// and the [HomeBottomsheet] widget.
  ///
  /// The bottom sheet is controlled by the [HomeController]
  /// and is displayed using the [Get.bottomSheet] method with
  /// [isScrollControlled] set to true.

  // onTapTxtBackToHome() {
  //   Get.bottomSheet(
  //     HomeBottomsheet(
  //       Get.put(
  //         HomeController(),
  //       ),
  //     ),
  //     isScrollControlled: true,
  //   );
  // }
}
