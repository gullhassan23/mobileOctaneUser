import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/CustomImageView.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:mobile_octane/Widgets/loading.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Registration_Screens/Forgetpassword.dart';
import 'package:mobile_octane/views/Registration_Screens/Select_Your_plan.dart';
import 'package:mobile_octane/views/Registration_Screens/Sign_Up.dart';

import '../../../Model/card_model.dart';
import '../../../Widgets/shimmer.dart';
import '../../../backend/auth.dart';
import '../../../global/refs.dart';
import '../../../main.dart';
import '../../../main3.dart';
import '../../../services/services/user_services.dart';


class Edit_Card extends StatefulWidget {
  bool fromsetting;

  Edit_Card({required this.fromsetting, super.key});

  @override
  State<Edit_Card> createState() => _Edit_CardState();
}

class _Edit_CardState extends State<Edit_Card> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cardnamecon = TextEditingController();
  TextEditingController cardnocon = TextEditingController();
  TextEditingController cvvcon = TextEditingController();
  TextEditingController expirycon = TextEditingController();
  UserServices _userServices = Get.find<UserServices>();
  @override
  void initState() {
    // TODO: implement initState
   
  // print(_userServices.customer.toString());
  // print(_userServices.customer.id!.toString()!="null");
      // if (_userServices.customer.id!="null" ){
        cardnamecon.text = _userServices.customer.card!.name ?? "";
        cardnocon.text = _userServices.customer.card!.number ?? "";
        cvvcon.text = _userServices.customer.card!.cvv ?? "";
        expirycon.text = _userServices.customer.card!.expiry ?? "";
      // }

   

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          surfaceTintColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  // Text("${_userServices.customer.toMap()}"),

                  SizedBox(height: 10.h),
                  Text("Connect Your Account ",
                      style: GoogleFonts.nunito(
                          color: AppColors.burColor,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800)),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40.w,
                      right: 40.w,
                    ),
                    child: GreyText(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      align: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 60.h),
                  _buildSignInFrame(
                      hintText: 'Name on Card', controller: cardnamecon),
                  SizedBox(height: 20.h),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              controller: cardnocon,
                              hintText: "Card Number",
                              maxLength: 16,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Card Number';
                                }
                                // Add additional validation rules as needed
                                return null;
                              },
                              prefix: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      20.h, 14.h, 12.h, 14.h),
                                  child: CustomImageView(
                                      imagePath: "assets/img_user.svg",
                                      height: 20.sp,
                                      color: AppColors.textColor,
                                      width: 20.sp)),
                              prefixConstraints:
                                  BoxConstraints(maxHeight: 48.h),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  // height: 40.h,
                                  width: 150.w,

                                  child: CustomTextFormField(
                                    expirydate: true,
                                    controller: expirycon,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Expiry';
                                      }
                                      // Add additional validation rules as needed
                                      return null;
                                    },
                                    contentPadding: EdgeInsets.all(15),
                                    hintText: "Expiry",
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.phone,
                                  ),
                                ),
                                SizedBox(
                                  // height: 45.h,
                                  width: 150.w,
                                  child: CustomTextFormField(
                                    contentPadding: EdgeInsets.all(15),
                                    controller: cvvcon,
                                    maxLength: 3,
                                    hintText: "CVV",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter CVV';
                                      }
                                      // Add additional validation rules as needed
                                      return null;
                                    },
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.number,
                                  ),
                                ),
                              ],
                            )
                          ])),
                  SizedBox(height: 120.h),

                  CustomElevatedButton(
                      text: widget.fromsetting ? "SAVE" : "NEXT",
                      margin: EdgeInsets.symmetric(horizontal: 20.h),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          CustomEasyLoading.show();
                          String docid = cardRef.doc().id;
                          CreditCard carddata = CreditCard(
                              name: '${cardnamecon.text}',
                              number: '${cardnocon.text}',
                              expiry: '${expirycon.text}',
                              cvv: '${cvvcon.text}',
                              id: docid);
                          checkUserLogin().then((value) {
                            customersRef
                                .doc(value
                                    ? FirebaseAuth.instance.currentUser!.uid
                                    : _userServices.customer.id)
                                .update({
                              "card.cvv": "${carddata.cvv}",
                              "card.id": "${carddata.id}",
                              "card.name": "${carddata.name}",
                              "card.number": "${carddata.number}",
                              "card.expiry": "${carddata.expiry}",
                            }).then((value) {
                              CustomEasyLoading.dismiss();
                                Navigator.pop(context);
                              
                            });
                          });
                        }
                      }),
                ]))));
  }

  /// Section Widget
  Widget _buildSignInFrame(
      {required TextEditingController controller, required String hintText}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomTextFormField(
            hintText: "${hintText}",
            controller: controller,
            textInputType: TextInputType.text,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(20.h, 14.w, 12.h, 14.w),
                child: CustomImageView(
                    imagePath: "assets/img_mask_group_2.png",
                    height: 20.sp,
                    color: AppColors.textColor,
                    width: 20.sp)),
            prefixConstraints: BoxConstraints(maxHeight: 48.h),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please $hintText';
              }
              // Add additional validation rules as needed
              return null;
            },
          )
        ]));
  }
}
