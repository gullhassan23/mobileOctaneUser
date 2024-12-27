import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/main3.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Registration_Screens/Select_your_Plan2.dart';
import 'package:provider/provider.dart';

import '../../Providers/PlansProviders.dart';
import '../../Widgets/shimmer.dart';
import '../../backend/auth.dart';
import '../../global/refs.dart';
import '../../main.dart';
import 'Add_Vechile/Add_Vehicle.dart';

class Select_Your_plan extends StatefulWidget {
  const Select_Your_plan({super.key});

  @override
  State<Select_Your_plan> createState() => _Select_Your_planState();
}

class _Select_Your_planState extends State<Select_Your_plan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 229, 203, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(241, 229, 203, 1),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
        child: Column(
          children: [
            RedText(
              "Select your Plan",
              color: AppColors.burColor,
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              ),
              child: GreyText(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                maxLines: 2,
                color: AppColors.textColor,
                // overflow: TextOverflow.ellipsis,
                align: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                final provider =
                    Provider.of<PlanProvider>(context, listen: false);
                provider.updatePlan(
                    "Free Plan",
                    provider.backgroundColor,
                    provider.textColor,
                    provider.textColor1,
                    provider.textColorPrice);
                provider.toggleBackgroundColor();
              },
              child: SizedBox(
                height: 90.h,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 10,
                  margin: EdgeInsets.all(0),
                  color: Provider.of<PlanProvider>(context).backgroundColor,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Free Plan",
                              style: GoogleFonts.nunito(
                                color: Provider.of<PlanProvider>(context)
                                    .textColor,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 150.w,
                                top: 2.h,
                                bottom: 2.w,
                              ),
                              child: Text(
                                "Free",
                                style: GoogleFonts.nunito(
                                  color: Provider.of<PlanProvider>(context)
                                      .textColorPrice,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Text(
                            "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet , comsectetur elit.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunito(
                              color:
                                  Provider.of<PlanProvider>(context).textColor1,
                              fontSize: 11.sp,
                              // fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // GestureDetector(
            //   onTap: (){

            //     final provider = Provider.of<PlanProvider>(context, listen: false);
            //     provider.updatePlan("Fleet", provider.backgroundColor, provider.textColor, provider.textColor1, provider.textColorPrice);
            //     provider.toggleBackgroundColor();
            //   },
            //   child: SizedBox(
            //     height: 90.h,
            //     child: Card(
            //       clipBehavior: Clip.antiAlias,
            //       elevation: 10,
            //       margin: EdgeInsets.all(0),
            //       color: Provider.of<PlanProvider>(context).backgroundColor,
            //       surfaceTintColor: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //       child: Padding(
            //         padding: EdgeInsets.only(left: 25.w,right: 25.w),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [

            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,

            //               children: [
            //                 Text(
            //                   "Fleet",
            //                   style: GoogleFonts.nunito(
            //                     color: Provider.of<PlanProvider>(context).textColor,
            //                     fontSize: 17.sp,
            //                     fontWeight: FontWeight.w700,
            //                   ),
            //                 ),
            //                 Padding(
            //                   padding: EdgeInsets.only(
            //                     left: 150.w,
            //                     top: 2.h,
            //                     bottom: 2.w,
            //                   ),
            //                   child: Text(
            //                     "\$25/m",
            //                     style: GoogleFonts.nunito(
            //                       color: Provider.of<PlanProvider>(context).textColorPrice,
            //                       fontSize: 11.sp,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Container(
            //               child: Text(
            //                 "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet , comsectetur elit.",
            //                 maxLines: 2,
            //                 overflow: TextOverflow.ellipsis,
            //                 style: GoogleFonts.nunito(
            //                   color: Provider.of<PlanProvider>(context).textColor1,
            //                   fontSize: 11.sp,
            //                   // fontFamily: 'Nunito',
            //                   fontWeight: FontWeight.w400,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // GestureDetector(
            //   onTap: (){

            //     final provider = Provider.of<PlanProvider>(context, listen: false);
            //     provider.updatePlan("Dummy", provider.backgroundColor, provider.textColor, provider.textColor1, provider.textColorPrice);
            //     provider.toggleBackgroundColor();
            //   },
            //   child: SizedBox(
            //     height: 90.h,
            //     child: Card(
            //       clipBehavior: Clip.antiAlias,
            //       elevation: 10,
            //       margin: EdgeInsets.all(0),
            //       color: Provider.of<PlanProvider>(context).backgroundColor,
            //       surfaceTintColor: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //       child: Padding(
            //         padding: EdgeInsets.only(left: 25.w,right: 25.w),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [

            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,

            //               children: [
            //                 Text(
            //                   "Dummy",
            //                   style: GoogleFonts.nunito(
            //                     color: Provider.of<PlanProvider>(context).textColor,
            //                     fontSize: 17.sp,
            //                     fontWeight: FontWeight.w700,
            //                   ),
            //                 ),
            //                 Padding(
            //                   padding: EdgeInsets.only(
            //                     left: 150.w,
            //                     top: 2.h,
            //                     bottom: 2.w,
            //                   ),
            //                   child: Text(
            //                     "\$25/m",
            //                     style: GoogleFonts.nunito(
            //                       color: Provider.of<PlanProvider>(context).textColorPrice,
            //                       fontSize: 11.sp,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Container(
            //               child: Text(
            //                 "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet , comsectetur elit.",
            //                 maxLines: 2,
            //                 overflow: TextOverflow.ellipsis,
            //                 style: GoogleFonts.nunito(
            //                   color: Provider.of<PlanProvider>(context).textColor1,
            //                   fontSize: 11.sp,
            //                   // fontFamily: 'Nunito',
            //                   fontWeight: FontWeight.w400,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            SizedBox(
              height: 80.h,
            ),
            CustomElevatedButton(
              text: " NEXT",
              onPressed: () async {
                CustomEasyLoading.show();
                await customersRef
                    .doc(auth.currentUser!.uid)
                    .update({"plan": 0}).then((value) {
                CustomEasyLoading.dismiss();

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Add_Vehicle_screen()));
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
