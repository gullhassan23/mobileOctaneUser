import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';

class Profile_Completed extends StatefulWidget {
  const Profile_Completed({super.key});

  @override
  State<Profile_Completed> createState() => _Profile_CompletedState();
}

class _Profile_CompletedState extends State<Profile_Completed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 150.h, left: 40.h,right: 40.h,),
              child: Column(
                children: [
                  Container(
                    height: 150.h,
                    width: 250.w,
                    child: SvgPicture.asset("assets/img_group_1000002028.svg",),
                  ),
                  SizedBox(height: 20.h,),

                  RedText("Profile Completed",color: AppColors.burColor,),
                  SizedBox(height: 10.h,),

                  GreyText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor idcididunt ut labore",color: AppColors.textColor,fontsize: 12.sp,align: TextAlign.center,),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}