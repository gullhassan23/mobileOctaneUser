import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import '../Constrants/Font.dart';

class TransactionReceiptDetailPage extends StatelessWidget {
  DocumentSnapshot detail;
  TransactionReceiptDetailPage({required this.detail, super.key});
  @override
  Widget build(BuildContext context) {
    DateTime createdAt = (detail['createdAt'] as Timestamp).toDate();
    String formattedDate =
        "${createdAt.day}-${createdAt.month}-${createdAt.year}";

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.white,
        title: Headline("Transaction Receipt"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction ID: #${detail['id']}',
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: AppColors.textColor),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${formattedDate}',
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: AppColors.textColor),
            ),
            SizedBox(height: 20),
            Text(
              'Vehicle:',
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: AppColors.textColor),
            ),
            buildItemRowvehicle('Name',
                '${detail['vehicleDetails']['vehiclename'].toString()}'),
            buildItemRowvehicle('Number',
                '${detail['vehicleDetails']['licensePlateNumber'].toString()}'),
            buildItemRowvehicle('Color',
                '${detail['vehicleDetails']['vehicleColor'].toString()}'),
            Divider(),
            Text(
              'Location:',
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: AppColors.textColor),
            ),
            buildItemRowvehicle(
                'Address', '${detail['location']['address'].toString()}'),
           Divider(),

            Text(
              'Payment Detail:',
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: AppColors.textColor),
            ),
            buildItemRow('${detail['fuel']['name'].toString()}',
                '${double.parse(detail['fuel']['PricePerLiter'].toString()).toStringAsFixed(2)} x \$${double.parse(detail['liters'].toString()).toStringAsFixed(2)}'),

            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),

            Center(
              child: Text(
                
                'Total Amount: \$ ${double.parse(detail['price'].toString()).toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.burColor
                ),
              ),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     // Implement any action on button press
            //   },
            //   child: Text('Print Receipt'),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildItemRow(String itemName, String itemPrice) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemName,
            style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: AppColors.textColor),
          ),
          Text(
            itemPrice,
            style: GoogleFonts.nunito(
                // fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: AppColors.textColor),
          ),
        ],
      ),
    );
  }

  Widget buildItemRowvehicle(String vehiclename, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            vehiclename,
            style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: AppColors.textColor),
          ),
          SizedBox(
              width: 200.w,
              child: Text(
                detail,
                style: GoogleFonts.nunito(
                    // fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: AppColors.textColor),
              )),
        ],
      ),
    );
  }
}
