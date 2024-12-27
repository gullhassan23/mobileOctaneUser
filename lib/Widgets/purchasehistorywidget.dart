// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:google_fonts/google_fonts.dart';

// import '../views/Constrants/Colors.dart';
// import '../views/Receipt/reciept.dart';

// class PurchaseHistoryWidget extends StatelessWidget {
//   final String title;
//   final String smalltitle;
//   const PurchaseHistoryWidget({
//     Key? key,
//     required this.title,
//     required this.smalltitle,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//        style: ElevatedButton.styleFrom(
//                   surfaceTintColor: Colors.transparent,
//                   backgroundColor: Color(0XFFF4F5F7),
//                   primary: Color(0XFFF4F5F7),
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(13.h),
//                   ),
//                 ),
//       onPressed: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionReceiptDetailPage()));
//         },
//       child: Padding(
//         padding: EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w,bottom: 10.h),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "\$${title}",
//               style: GoogleFonts.nunito(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15.sp,
//                 color: AppColors.textColor
//               ),
//             ),
//             Text(
//               smalltitle,
//               style: GoogleFonts.nunito(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15.sp,
//                   color: AppColors.burColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }