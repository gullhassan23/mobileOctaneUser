import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import '../../Model/FuelUp_model.dart';
import '../../Widgets/purchasehistorywidget.dart';
import '../../global/refs.dart';
import '../../services/services/user_services.dart';
import '../Receipt/reciept.dart';

class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({super.key});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  UserServices _userServices = Get.find<UserServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.white,
        title: Headline("Purchase History"),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<Map<String, List<DocumentSnapshot>>>(
                stream: fuelTransaction
                    .doc(_userServices.customer.id)
                    .collection("Transaction")
                    .orderBy("createdAt", descending: true)
                    .snapshots()
                    .map((querySnapshot) {
                  Map<String, List<DocumentSnapshot>> groupedData = {};

                  querySnapshot.docs.forEach((document) {
                    DateTime createdAt =
                        (document['createdAt'] as Timestamp).toDate();
                    String formattedDate =
                        "${createdAt.day}-${createdAt.month}-${createdAt.year}";

                    if (!groupedData.containsKey(formattedDate)) {
                      groupedData[formattedDate] = [];
                    }
                    groupedData[formattedDate]!.add(document);
                  });

                  return groupedData;
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: AppColors.Button1,
                    ));
                  }
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Data Not Found",
                              style: GoogleFonts.nunito(
                                  fontSize: 16.sp,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: -0.2)),
                        ),
                      ),
                    );
                  }
                  Map<String, List<DocumentSnapshot>>? groupedData =
                      snapshot.data;

                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: groupedData!.length,
                      itemBuilder: (context, index) {
                        String date = groupedData.keys.elementAt(index);
                        List<DocumentSnapshot> transactions =
                            groupedData[date]!;
                        DateTime currentDate = DateTime.now();
                        String currentDateString =
                            "${currentDate.day}-${currentDate.month}-${currentDate.year}";
                        DateTime previousDate =
                            currentDate.subtract(Duration(days: 1));

                        String previousDateString =
                            "${previousDate.day}-${previousDate.month}-${previousDate.year}";

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              date == currentDateString
                                  ? "Today"
                                  : date == previousDateString
                                      ? "Tomorrow"
                                      : "$date",
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: AppColors.textColor),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: transactions.length,
                              itemBuilder: (context, index) {
                                // Display individual transactions here
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        surfaceTintColor: Colors.transparent,
                                        backgroundColor: Color(0XFFF4F5F7),
                                        // primary: Color(0XFFF4F5F7),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13.h),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TransactionReceiptDetailPage(detail: transactions[index],)));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.h,
                                            right: 10.w,
                                            left: 10.w,
                                            bottom: 10.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${double.parse(transactions[index]['price'].toString()).toStringAsFixed(2)} fill up",
                                              style: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp,
                                                  color: AppColors.textColor),
                                            ),
                                            Text(
                                              "${transactions[index]['fuel']['name'].toString()}",
                                              style: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp,
                                                  color: AppColors.burColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // PurchaseHistoryWidget(
                                    //     title:
                                    //         "${double.parse(transactions[index]['price'].toString()).toStringAsFixed(2)} fill up",
                                    //     smalltitle:
                                    //         "${transactions[index]['fuel']['name'].toString()}"),
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }

                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
