import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';

class fill_up_completed_screen extends StatefulWidget {
  const fill_up_completed_screen({super.key});

  @override
  State<fill_up_completed_screen> createState() => _fill_up_completed_screenState();
}

class _fill_up_completed_screenState extends State<fill_up_completed_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.backgroundColor,
        title: Headline("Fill Up"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 140.h,),
            Container(
              height: 150.h,
              width: 200.w,
              child: SvgPicture.asset("assets/img_group_1000002028.svg"),
            ),
            SizedBox(height: 10.h,),
            RedText("Order Completed",color: AppColors.burColor,),
            SizedBox(height: 10.h,),

            SizedBox(
              width: 290.w,
                child: GreyText("Lorem ipsum dolor sit amet, consecteturn adipiscing elit, sed do eiusmod tempor idcididunt ut labore.",align: TextAlign.center,fontsize: 12.sp,color: Colors.black54,)),

          ],
        ),
      ),
    );
  }
}