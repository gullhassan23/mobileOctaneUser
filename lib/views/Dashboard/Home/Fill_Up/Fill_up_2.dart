import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/CustomImageView.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';
import 'package:mobile_octane/views/AddLocationScreen/add_location_screen.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Dashboard/Open_a_Franchhise/Open_a_franchise.dart';

import '../../../Constrants/Colors.dart';

class Fill_Up_2 extends StatefulWidget {
  const Fill_Up_2({super.key});

  @override
  State<Fill_Up_2> createState() => _Fill_Up_2State();
}

class _Fill_Up_2State extends State<Fill_Up_2> {
  bool isChecked = false;
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Headline("Fill Up"),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            EdgeInsets.only(top: 20.h, bottom: 10.h, left: 15.h, right: 15.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing rlit. Vestibility edge felis tellus",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          fontSize: 13.sp,
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.2)),
                ),
              ),
              SizedBox(height: 20.h),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Select Time",
                    style: GoogleFonts.nunito(
                        color: AppColors.textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  hintText: "hh/mm",
                  textInputType: TextInputType.phone,
                  textStyle: GoogleFonts.nunito(
                    fontSize: 12.sp,
                    color: AppColors.textColor,
                  ),
                  prefix: Container(
                      margin: EdgeInsets.fromLTRB(20.h, 14.w, 12.h, 14.w),
                      child: CustomImageView(
                          imagePath: "assets/img_mask_group_4.png",
                          height: 20.sp,
                          color: AppColors.textColor,
                          width: 20.sp)),
                  prefixConstraints: BoxConstraints(maxHeight: 48.h),
                )
              ]),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Select Fuel",
                    style: GoogleFonts.nunito(
                        fontSize: 14.sp,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.6)),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(2.0),
                        color: isChecked ? Colors.red : Colors.white,
                        border: Border.all(
                          color: isChecked ? Colors.red : Colors.grey,
                        ),
                      ),
                      child: isChecked
                          ? Image.asset(
                              "assets/img_mask_group_12x12.png",
                            )
                          : Container(),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text("91 Octane Gasoline",
                      style: GoogleFonts.nunito(
                          fontSize: 14.sp,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.6)),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isCheck = !isChecked;
                      });
                    },
                    child: Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(2.0),
                        color: isCheck ? Colors.red : Colors.white,
                        border: Border.all(
                          color: isCheck ? Colors.red : Colors.grey,
                        ),
                      ),
                      child: isCheck
                          ? Image.asset(
                              "assets/img_mask_group_12x12.png",
                            )
                          : Container(),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text("Diesel",
                      style: GoogleFonts.nunito(
                          fontSize: 14.sp,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.6)),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Price",
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400)),
                SizedBox(height: 13.h),
             
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 90.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.2), // Grey color with 50% opacity
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: Offset(0, 3), // Offset to bottom-right
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("34\$",
                            style: GoogleFonts.nunito(
                                fontSize: 32.sp,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                letterSpacing: -0.2)),
                      ],
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Text("Enter Litter",
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp,
                        color: const Color(0xFF000000).withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.6)),
              ),
              SizedBox(
                height: 80.h,
              ),
              CustomElevatedButton(
                  text: "NEXT",
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => add_location_screen()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
