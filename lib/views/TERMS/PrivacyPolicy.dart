// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_octane/views/Constrants/Font.dart';

// import '../Constrants/Colors.dart';

// class PrivacyPolicy extends StatelessWidget {
//   const PrivacyPolicy({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.backgroundColor,
//         surfaceTintColor: Colors.transparent,
//         title: Headline("Privacy Policy"),
//         centerTitle: true,
//         elevation: 0.0,
//       ),
//       body: Padding(
//         padding:
//             EdgeInsets.only(left: 10.w, top: 4.h, right: 10.w, bottom: 10.h),
//         child: SingleChildScrollView(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna",
//                   style: GoogleFonts.nunito(
//                       fontSize: 14.sp, color: AppColors.textColor),
//                   textAlign: TextAlign.justify,
//                 ),
//                 SizedBox(height: 10.h,),
//                 Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pecenas pulvinar bibendum magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna",
//                   style: GoogleFonts.nunito(
//                       fontSize: 14.sp, color: AppColors.textColor),
//                   textAlign: TextAlign.justify,
//                 ),
//                 SizedBox(height: 10.h,),

//                 Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pecenas pulvinar bibendum magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna",
//                   style: GoogleFonts.nunito(
//                       fontSize: 14.sp, color: AppColors.textColor),
//                   textAlign: TextAlign.justify,
//                 ),
//                 SizedBox(height: 10.h,),

//                 Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna ",
//                   style: GoogleFonts.nunito(
//                       fontSize: 14.sp, color: AppColors.textColor),
//                   textAlign: TextAlign.justify,
//                 )
//               ]),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';

import '../../global/refs.dart';
import '../Constrants/Colors.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Headline("Privacy Policy"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: 10.w, top: 4.h, right: 10.w, bottom: 10.h),
        child: FutureBuilder<DocumentSnapshot>(
          future: PrivacyPolicyRef
              .doc('jXtpAyj5HAJI3142pTy2')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var data = snapshot.data?.data() as Map<String, dynamic>?;

              if (data == null) {
                return Text('No data found.');
              }

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "" "${data['detail']}  """?? '',
                      style: GoogleFonts.nunito(
                          fontSize: 14.sp, color: AppColors.textColor),
                      textAlign: TextAlign.justify,
                    ),
                   
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
