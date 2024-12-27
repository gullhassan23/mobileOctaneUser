import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/CustomImageView.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';
import 'package:mobile_octane/Widgets/loading.dart';
import 'package:mobile_octane/global/refs.dart';
import 'package:mobile_octane/services/services/user_services.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Registration_Screens/Connect_Your_Account.dart';

import '../../Model/customer_model.dart';
import '../../Widgets/shimmer.dart';
import '../../backend/auth.dart';
import '../../main.dart';
import '../../main3.dart';

class Create_Profile extends StatefulWidget {
  const Create_Profile({super.key});

  @override
  State<Create_Profile> createState() => _Create_ProfileState();
}

class _Create_ProfileState extends State<Create_Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController namecon = TextEditingController();
  TextEditingController emailcom = TextEditingController();
  UserServices _userServices = Get.find<UserServices>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(241, 229, 203, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(241, 229, 203, 1),
          surfaceTintColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  // Text("${_userServices.customer.toMap()}"),
                  SizedBox(height: 4.h),
                  Text("Create Profile",
                      style: GoogleFonts.nunito(
                          color: Color.fromRGBO(143, 9, 49, 1),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800)),
                  SizedBox(
                    height: 10.h,
                  ),
                  GreyText(
                    "Add Your basics Details",
                    color: Color.fromRGBO(1, 2, 3, 1),
                    fontsize: 14.sp,
                  ),
                  SizedBox(height: 60.h),
                  _buildSignInFrame(
                      controller: namecon,
                      hinttitle: 'Enter Your Name',
                      title: 'Name'),
                  SizedBox(height: 20.h),
                  _buildSignInFrame(
                      controller: emailcom,
                      hinttitle: 'Enter Your Email',
                      title: 'Email'),
                  SizedBox(height: 120.h),
                  CustomElevatedButton(
                      text: "NEXT",
                      margin: EdgeInsets.symmetric(horizontal: 20.h),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          CustomEasyLoading.show();

                          checkUserLogin().then((value) {
                            print(value);
                            customersRef
                                .doc(value
                                    ? FirebaseAuth.instance.currentUser!.uid
                                    : _userServices.customer.id)
                                .update({
                              "email": emailcom.text,
                              "name": namecon.text
                            }).then((value) {
                              controller.user.value=CustomerModel();
                              CustomEasyLoading.dismiss();

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Connect_Your_Account(
                                            fromsetting: false,
                                          )));
                            }).onError((error, stackTrace) {
                              print(
                                  "error = $error ${_userServices.customer.id}");
                            });
                          });
                        }
                      }),
                ]))));
  }

  /// Section Widget

  /// Section Widget
  Widget _buildSignInFrame(
      {required TextEditingController controller,
      required String title,
      required String hinttitle}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${title}",
              style: GoogleFonts.nunito(
                  color: Color.fromRGBO(1, 2, 3, 1),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 10.h),
          CustomTextFormField(
            hintText: "${hinttitle}",
            textInputType: TextInputType.text,
            controller: controller,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(20.h, 14.w, 12.h, 14.w),
                child: CustomImageView(
                    imagePath: "assets/img_mask_group_2.png",
                    height: 20.sp,
                    color: Color.fromRGBO(1, 2, 3, 1),
                    width: 20.sp)),
            prefixConstraints: BoxConstraints(maxHeight: 48.h),
            // validator: (value) {
            //   if (!isValidPhone(value)) {
            //     return "err_msg_please_enter_valid_phone_number".tr;
            //   }
            //   return null;
            // }
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please $hinttitle';
              }
              // Add additional validation rules as needed
              return null;
            },
          )
        ]));
  }
}
