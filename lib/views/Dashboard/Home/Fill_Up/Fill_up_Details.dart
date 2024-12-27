import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/PaymentSuccessScreen/payment_success_screen.dart';

class fill_up_Details extends StatefulWidget {
  const fill_up_Details({super.key});

  @override
  State<fill_up_Details> createState() => _fill_up_DetailsState();
}

class _fill_up_DetailsState extends State<fill_up_Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor:AppColors.backgroundColor ,
          centerTitle: true,
          title: Headline("Fill Up Details"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Column(children: [
              SizedBox(height: 20.h),
              Align(alignment: Alignment.centerLeft, child: Headline("Price")),

              SizedBox(height: 20.h),
              
              Container(
                height: 80.h,
                 
                  padding:
                      EdgeInsets.only(left : 10.w, right: 10.w,top: 10.w,bottom: 10.w),
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
                  // decoration: AppDecoration.white
                  //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        
                        Row(
                          children: [
                            Text(
                                  "Total:",
                                 
                                  style: GoogleFonts.nunito( // Use GoogleFonts.poppins
                                    fontSize:  16.sp,
                                    color:  Color(0xffE41B23),
                                    fontWeight: FontWeight.w600,
                                    fontStyle:  FontStyle.normal,
                                  ),
                                ),
                                 Text(
                                  "\$50 fill up",
                                 
                                  style: GoogleFonts.nunito( // Use GoogleFonts.poppins
                                    fontSize:  16.sp,
                                    color:  AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle:  FontStyle.normal,
                                  ),
                                ),
                          ],
                        ),
                      
                         Text(
                                  "Diesel",
                                 
                                  style: GoogleFonts.nunito( // Use GoogleFonts.poppins
                                    fontSize:  16.sp,
                                    color:  AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle:  FontStyle.normal,
                                  ),
                                ),
                      ]),
                      SizedBox(height: 10.h,),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                                    "\$10 fill up each",
                                   
                                    style: GoogleFonts.nunito( // Use GoogleFonts.poppins
                                      fontSize:  16.sp,
                                      color:  AppColors.textColor,
                                      fontWeight: FontWeight.w600,
                                      fontStyle:  FontStyle.normal,
                                    ),
                                  ),
                        ),
                    ],
                    
                  )),


                   SizedBox(height: 20.h),
              Align(alignment: Alignment.centerLeft, child: Headline("Vehicles")),
              SizedBox(
                height: 20.h,
              ),
              Container(
                  margin: EdgeInsets.only(right: 10.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15.h),
                        child: _buildViewColumn(
                            vehicleCount: "Vehicle 1",
                            licenceNumber: "Licence Number: 86573"))
                  ])),
              SizedBox(height: 16.h),
              Container(
                  margin: EdgeInsets.only(right: 10.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
                  // decoration: AppDecoration.white
                  //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                    
                    Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: _buildViewColumn(
                            vehicleCount: "Vehicle 2",
                            licenceNumber: "Licence Number: 86573"))
                  ])),
              SizedBox(height: 15.h),
              // _buildSelectAllColumn(),
              SizedBox(height: 5.h)
            ]),
          ),
        ),
        bottomNavigationBar: _buildNext(context));
  }

  /// Section Widget

  /// Section Widget
  Widget _buildNext(BuildContext context) {
    return CustomElevatedButton(
        text: "Next".toUpperCase(),
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
        onPressed: () {
          // onTapNext();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => payment_success_screen()));
        });
  }

  /// Common widget
  Widget _buildViewColumn({
    required String vehicleCount,
    required String licenceNumber,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(vehicleCount,
          style: GoogleFonts.nunito(
              color: AppColors.textColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600)),
      SizedBox(height: 2.h),
      Text(licenceNumber,
          style: GoogleFonts.nunito(
              color: Color(0XFF525252),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400))
    ]);
  }
}
