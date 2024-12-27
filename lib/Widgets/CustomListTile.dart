import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTileWidget extends StatelessWidget {
  final String icon;
  final String bigText;
  final String smallText;
  final Color bgcolor;
  final Color? iconcolor;

  const CustomListTileWidget({
    Key? key,
    required this.icon,
    required this.bigText,
    required this.smallText,
    required this.bgcolor,
    this.iconcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundColor: bgcolor,
          child: SvgPicture.asset(icon, color: iconcolor),
        ),
        SizedBox(width: 10.w), // Adjust the spacing as needed
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bigText,
              style: GoogleFonts.nunito(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h,),
            Text(
              smallText,
              style: GoogleFonts.nunito(
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
