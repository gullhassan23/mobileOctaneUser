// import '../controller/subscription_plan_one_controller.dart';
// import '../models/userprofile_item_model.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_fueling/core/app_export.dart';

// // ignore: must_be_immutable
// class UserprofileItemWidget extends StatelessWidget {
//   UserprofileItemWidget(
//     this.userprofileItemModelObj, {
//     Key? key,
//   }) : super(
//           key: key,
//         );

//   UserprofileItemModel userprofileItemModelObj;

//   var controller = Get.find<SubscriptionPlanOneController>();

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       clipBehavior: Clip.antiAlias,
//       elevation: 0,
//       margin: EdgeInsets.all(0),
//       color: appTheme.black900,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadiusStyle.roundedBorder10,
//       ),
//       child: Container(
//         height: 112.v,
//         width: 390.h,
//         padding: EdgeInsets.symmetric(
//           horizontal: 20.h,
//           vertical: 17.v,
//         ),
//         decoration: AppDecoration.outlineBlack.copyWith(
//           borderRadius: BorderRadiusStyle.roundedBorder10,
//         ),
//         child: Stack(
//           alignment: Alignment.topCenter,
//           children: [
//             Align(
//               alignment: Alignment.center,
//               child: Container(
//                 height: 72.v,
//                 width: 350.h,
//                 decoration: BoxDecoration(
//                   color: appTheme.black900,
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.topCenter,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Obx(
//                     () => Text(
//                       userprofileItemModelObj.freePlanText!.value,
//                       style: TextStyle(
//                         color: theme.colorScheme.onPrimary.withOpacity(1),
//                         fontSize: 18.fSize,
//                         fontFamily: 'Nunito',
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: 232.h,
//                       top: 2.v,
//                       bottom: 2.v,
//                     ),
//                     child: Obx(
//                       () => Text(
//                         userprofileItemModelObj.priceText!.value,
//                         style: TextStyle(
//                           color: theme.colorScheme.onPrimary.withOpacity(1),
//                           fontSize: 14.fSize,
//                           fontFamily: 'Nunito',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Container(
//                 width: 312.h,
//                 margin: EdgeInsets.only(bottom: 1.v),
//                 child: Obx(
//                   () => Text(
//                     userprofileItemModelObj.descriptionText!.value,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: theme.colorScheme.onPrimary.withOpacity(1),
//                       fontSize: 14.fSize,
//                       fontFamily: 'Nunito',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
