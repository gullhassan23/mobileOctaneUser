import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../views/Constrants/Colors.dart';
import 'strip.dart';

class MyPaymentForm extends StatefulWidget {
  @override
  _MyPaymentFormState createState() => _MyPaymentFormState();
}

class _MyPaymentFormState extends State<MyPaymentForm> {
  late Map<String, dynamic> paymentIntentData;
  bool isPaymentCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          margin: EdgeInsets.only(right: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2.r,
                blurRadius: 2.r,
                offset: Offset(
                  0,
                  0,
                ),
              ),
            ],
          ),
          // decoration: Colors.white
          //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 15.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("vehicleCount",
                            style: GoogleFonts.mulish(
                                // color: Color(0XFF5A5A5A),
                                color: AppColors.textColor,
                                fontSize: 15.sp,
                                // fontFamily: 'Mulish',
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 2.h),
                        Text("licenceNumber",
                            style: GoogleFonts.nunito(
                                // color: Color(0XFF525252),
                                color: AppColors.textColor,
                                fontSize: 11.sp,
                                // fontFamily: 'Nunito',
                                fontWeight: FontWeight.w400))
                      ])),
            ],
          )),
      Center(
        child: ElevatedButton(
          onPressed: () {
            StripePaymentHandle stripe=StripePaymentHandle();
           stripe.stripeMakePayment();
          },
          child: Text('Pay with Stripe'),
        ),
      ),
    ]));
  }

  Future makePayment() async {
    try {
      await displayPaymentSheet(context);
      paymentIntentData = await createPaymentIntent();
      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "US",
        testEnv: true,
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData["client_secret"],
          style: ThemeMode.light,
          merchantDisplayName: "HASSAN",
          googlePay: gpay,
        ),
      );
    } catch (e) {
      print('Error in makePayment: $e');
      // Handle error, show user-friendly message
    }
  }

  Future<void> displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Payment completed');
      setState(() {
        isPaymentCompleted = true;
      });
    } catch (e) {
      print('Payment failed');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {
        "amount": "100",
        "currency": "USD",
      };

      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          "Authorization":
              "Bearer sk_test_51LYvOaG5oJVKdCdoSBgJVQY3FtPewAydxJ7k5uWmr2wUu4l9pRlDExp6SjqSpT2Lcdw26a60CEhzwlPANWymF9E700qG7AlO7L",
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );

      print("Payment Intent Response: ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      print('Error in createPaymentIntent: $e');
      throw Exception(e.toString());
    }
  }
}
