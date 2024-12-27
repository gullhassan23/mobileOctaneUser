import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';

class Open_a_franchise extends StatelessWidget {
  const Open_a_franchise({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Headline(
          "Open a Franchise",
          
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.h, top: 4.h, right: 20.h),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna",
            style: GoogleFonts.nunito(
              fontSize: 15.sp,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10.h,),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pecenas pulvinar bibendum magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna",
            style: GoogleFonts.nunito(fontSize: 15.sp),
            textAlign: TextAlign.justify,
          ),
              SizedBox(height: 10.h,),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pecenas pulvinar bibendum magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna",
            style: GoogleFonts.nunito(fontSize: 15.sp),
            textAlign: TextAlign.justify,
          ),
              SizedBox(height: 10.h,),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna ",
            style: GoogleFonts.nunito(fontSize: 15.sp),
            textAlign: TextAlign.justify,
          ),
              SizedBox(height: 10.h,),

        ]),
      ),
    );
  }
}