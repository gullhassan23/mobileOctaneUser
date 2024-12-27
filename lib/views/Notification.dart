import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_octane/Widgets/CustomListTile.dart';
import 'package:mobile_octane/main3.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';

import '../Model/notificationmodel.dart';
import '../Widgets/shimmer.dart';
import '../global/refs.dart';
import '../main.dart';
import '../services/services/user_services.dart';
import 'Receipt/reciept.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  UserServices _userServices = Get.find<UserServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        title: Headline(
          "Notification",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 15.w,
          top: 15.h,
          right: 15.w,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: notificationRef
                        .doc(_userServices.customer.id)
                        .collection("notification")
                        .orderBy("created", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      // print(snapshot.data!.docs.length);
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              // var document = snapshot.data!.docs[index];
                              List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              List<NotificationModel> notification =
                                  documents.map((doc) {
                                return NotificationModel.fromMap(
                                    doc.data() as Map<String, dynamic>);
                              }).toList();
                              print(notification[index].created);
                              DateTime parsedDate = DateTime.parse(
                                  notification[index].created.toString());

                              DateTime now = DateTime.now();

                              String formattedDate =
                                  getFormattedDate(parsedDate, now);
                              return Column(
                                children: [
                                  if (notification[index]
                                          .title
                                          .toString()
                                          .toLowerCase() ==
                                      "fill me up")
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        print(
                                            "${notification[index].transactionid}");
                                        CustomEasyLoading.show();
                                        DocumentSnapshot documentSnapshot =
                                            await fuelTransaction
                                                .doc(_userServices.customer.id)
                                                .collection("Transaction")
                                                .doc(notification[index]
                                                    .transactionid)
                                                .get();

                                        CustomEasyLoading.dismiss();

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TransactionReceiptDetailPage(
                                                      detail: documentSnapshot,
                                                    )));
                                      },
                                      child: Column(
                                        children: [
                                          CustomListTileWidget(
                                              // bgcolor: Colors.yellow.shade50,
                                              // icon: "assets/img_category.svg",
                                              bgcolor: Colors.pink.shade50,
                                              icon:
                                                  "assets/img_shield_done_pink_a200.svg",
                                              bigText:
                                                  "${notification[index].title}",
                                              // smallText: "Today | 09:24 AM"),
                                              smallText: "$formattedDate"),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${notification[index].body}",
                                                style: GoogleFonts.nunito(
                                                  fontSize: 12.sp,
                                                  color: AppColors.textColor,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  if (notification[index]
                                          .title
                                          .toString()
                                          .toLowerCase() ==
                                      "system updates")
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {},
                                      child: Column(
                                        children: [
                                          CustomListTileWidget(
                                              bgcolor: Colors.blue.shade50,
                                              icon:
                                                  "assets/img_shield_done_pink_a200.svg",
                                              iconcolor: Colors.green,
                                              bigText:
                                                  "${notification[index].title}!",
                                              // smallText: "Today | 09:24 AM"),
                                              smallText: "$formattedDate"),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 310.w,
                                                child: Text(
                                                  "${notification[index].body}",
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 12.sp,
                                                    color: AppColors.textColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  // Divider(),
                                ],
                              );
                            });
                      }
                      return Container();
                    }),

                // CustomListTileWidget(
                //     bgcolor: Colors.yellow.shade50,
                //     icon: "assets/img_category.svg",
                //     bigText: "Your request accepted",
                //     smallText: "Today | 09:24 AM"),
                // SizedBox(
                //   height: 5.h,
                // ),
                // Text(
                //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ",
                //   style: GoogleFonts.nunito(
                //     fontSize: 12.sp,
                //     color: AppColors.textColor,
                //   ),
                //   textAlign: TextAlign.justify,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getFormattedDate(DateTime originalDate, DateTime now) {
    if (originalDate.year == now.year &&
        originalDate.month == now.month &&
        originalDate.day == now.day) {
      // Today
      return 'Today | ' + DateFormat("hh:mm a").format(originalDate);
    } else if (originalDate.year == now.year &&
        originalDate.month == now.month &&
        originalDate.day == now.day - 1) {
      // Yesterday
      return 'Yesterday | ' + DateFormat("hh:mm a").format(originalDate);
    } else {
      // Other dates
      return DateFormat("MMM, dd, yyyy | hh:mm a").format(originalDate);
    }
  }
}
