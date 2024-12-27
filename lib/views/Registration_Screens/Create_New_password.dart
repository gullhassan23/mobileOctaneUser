import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/CustomImageView.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';

import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Registration_Screens/Forgetpassword.dart';
import 'package:mobile_octane/views/Registration_Screens/Sign_Up.dart';

class Create_new_password extends StatefulWidget {
  const Create_new_password({super.key});

  @override
  State<Create_new_password> createState() => _Create_new_passwordState();
}

class _Create_new_passwordState extends State<Create_new_password> {
  @override
  Widget build(BuildContext context) {
     return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
            //resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        
                        child: SizedBox(
                            width: double.maxFinite,
                            child: Column(children: [
                              _buildSkipSection(),
                              SizedBox(height: 4.h),
                              Text("Create New Password",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 22.sp,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w800)),
                                      SizedBox(height: 10.h,),
                                      GreyText("Create a New Password for Your Account"),
                              SizedBox(height: 60.h),
                              _buildPasswordFrame(),
                              SizedBox(height: 20.h),
                              _buildPasswordFrame(),
                              SizedBox(height: 120.h),
                              CustomElevatedButton(
                                  text: "SAVE",
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.h),
                                  onPressed: () {
                                   
                                  }),
                             
                            ])))))));
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
                  decoration: BoxDecoration(
                      color: Colors.white)))
        ]));
  }

  /// Section Widget
  Widget _buildSignInFrame() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Phone Number",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400)),
          SizedBox(height: 13.h),
          CustomTextFormField(
             
              hintText: "Enter Phone number",
              textInputType: TextInputType.phone,
              prefix: Container(
                  margin: EdgeInsets.fromLTRB(20.h, 14.w, 12.h, 14.w),
                  child: CustomImageView(
                      imagePath: "assets/img_mask_group.png",
                      height: 20.sp,
                      width: 20.sp)),
              prefixConstraints: BoxConstraints(maxHeight: 48.h),
              // validator: (value) {
              //   if (!isValidPhone(value)) {
              //     return "err_msg_please_enter_valid_phone_number".tr;
              //   }
              //   return null;
              // }
              )
        ]));
  }

  /// Section Widget
  Widget _buildPasswordFrame() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Password",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400)),
          SizedBox(height: 13.h),
           CustomTextFormField(
              // controller: controller.passwordController,
              hintText: "Enter password",
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              prefix: Container(
                  margin: EdgeInsets.fromLTRB(20.h, 14.h, 12.h, 14.h),
                  child: CustomImageView(
                      imagePath: "assets/img_mask_group_20x20.png",
                      height: 20.sp,
                      width: 20.sp)),
              prefixConstraints: BoxConstraints(maxHeight: 48.h),
              suffix: InkWell(
                  onTap: () {
                   
                  },
                  child: Container(
                      margin: EdgeInsets.fromLTRB(30.h, 14.h, 20.h, 14.w),
                      child: CustomImageView(
                          imagePath: "assets/img_mask_group_1.png",
                          height: 20.sp,
                          width: 20.sp))),
              suffixConstraints: BoxConstraints(maxHeight: 48.h),
              // validator: (value) {
              //   if (value == null ||
              //       (!isValidPassword(value, isRequired: true))) {
              //     return "err_msg_please_enter_valid_password".tr;
              //   }
              //   return null;
              // },
              //obscureText: controller.isShowPassword.value,
              contentPadding: EdgeInsets.symmetric(vertical: 13.h)),
        SizedBox(height: 13.h),
         
        ]));
  }

  /// Section Widget
  Widget _buildLineRow() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              child: SizedBox(
                  width: 120.h, child: Divider(color: Colors.grey))),
          Padding(
              padding: EdgeInsets.only(left: 12.h),
              child: Text("or",
                  style: TextStyle(
                      color:Colors.black,
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