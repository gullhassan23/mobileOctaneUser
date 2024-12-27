// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../views/Constrants/Colors.dart';

// class FAQContainer extends StatelessWidget {
//   final String title;
//   final String icon;
//   const FAQContainer({
//     Key? key,
//     required this.title,
//     required this.icon,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       decoration: BoxDecoration(
//         border: Border.all(),
//         shape: BoxShape.rectangle,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h,bottom: 10.h),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: GoogleFonts.nunito(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15.sp,
//               ),
//             ),
//             SvgPicture.asset(icon,color: AppColors.burColor,),
//           ],
//         ),
//       ),
//     );
//   }
// }
