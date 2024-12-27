import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/CustomImageView.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Registration_Screens/Connect_Your_Account.dart';
import 'package:mobile_octane/views/Registration_Screens/Forgetpassword.dart';
import 'package:mobile_octane/views/Registration_Screens/Sign_Up.dart';

import '../../../Widgets/shimmer.dart';
import '../../../global/refs.dart';
import '../../../main.dart';
import '../../../main3.dart';
import '../../../services/services/user_services.dart';
import '../../Constrants/Colors.dart';

class Edit_Profile extends StatefulWidget {
  const Edit_Profile({super.key});

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  UserServices _userServices = Get.find<UserServices>();
  TextEditingController namecon = TextEditingController();
  TextEditingController emailcom = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState\
    namecon.text = _userServices.customer.name.toString();
    emailcom.text = _userServices.customer.email.toString();

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
          title: Headline("Edit Profile"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(height: 30.h),
          _buildSignInFrame(
              controller: namecon, hinttitle: 'Enter Your Name', title: 'Name'),
          SizedBox(height: 20.h),
          IgnorePointer(
            ignoring: _userServices.customer.google.toString().toLowerCase() ==
                    "false"
                ? false
                : true,
            child: _buildSignInFrame(
                controller: emailcom,
                hinttitle: 'Enter Your Email',
                title: 'Email'),
          ),
          SizedBox(height: 300.h),
          CustomElevatedButton(
              text: "SAVE",
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              onPressed: () async {
                CustomEasyLoading.show();
                await _userServices.updateProfile(
                    email: emailcom.text, name: namecon.text, image: '');
                Navigator.pop(context);
                // customersRef.doc(_userServices.customer.id).update({
                //   "email": emailcom.text,
                //   "name": namecon.text
                // }).then((value) {
                // });
              }),
        ])));
  }

  /// Section Widget
  Widget _buildSkipSection() {
    return SizedBox(
        height: 30.h,
        width: double.maxFinite,
        child: Stack(alignment: Alignment.center, children: [
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: EdgeInsets.only(right: 20.h, bottom: 13.h),
                  child: Text("skip",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w500)))),
          Align(
              alignment: Alignment.center,
              child: Container(
                  height: 77.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(color: Colors.white)))
        ]));
  }

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

  /// Section Widget
  Widget _buildLineRow() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              child:
                  SizedBox(width: 120.h, child: Divider(color: Colors.grey))),
          Padding(
              padding: EdgeInsets.only(left: 12.h),
              child: Text("or",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400))),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              child: SizedBox(
                  width: 120.h,
                  child: Divider(color: Colors.grey, indent: 8.h)))
        ]));
  }
}
