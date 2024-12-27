import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/CustomImageView.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Dashboard/Home/HomeScreen.dart';
import 'package:mobile_octane/views/Registration_Screens/Forgetpassword.dart';
import 'package:mobile_octane/views/Registration_Screens/Sign_Up.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../../AuthenticationService/AuthenticationService.dart';
import '../../Widgets/shimmer.dart';
import '../../backend/auth.dart';
import '../../binding/authbinding.dart';
import '../../main.dart';
import '../../main3.dart';

class Sign_In extends StatefulWidget {
  const Sign_In({super.key});

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  TextEditingController phoneNumbercon = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String countrycode = "+92";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
                child: Column(children: [
              SizedBox(height: 90.h),
              Text("Sign In",
                  style: GoogleFonts.nunito(
                      color: AppColors.burColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800)),
              SizedBox(height: 60.h),
              _buildSignInFrame(
                  controller: phoneNumbercon, selectedCountryCode: "+92"),
              SizedBox(height: 20.h),
              _buildPasswordFrame(),
              SizedBox(height: 30.h),
              CustomElevatedButton(
                  text: "SIGN IN",
                  margin: EdgeInsets.symmetric(horizontal: 20.h),
                  onPressed: () {
                    CustomEasyLoading.show();
                    loginwithphone("${countrycode}${phoneNumbercon.text}",
                        passwordController.text, context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Homescreen()));
                  }),
              SizedBox(height: 16.h),
              Text.rich(
                TextSpan(
                  text: 'Don\'t have an account? ',
                  style: GoogleFonts.nunito(
                      color: Colors.black54, fontSize: 12.sp),
                  children: [
                    TextSpan(
                      text: 'SIGN UP',
                      style: GoogleFonts.nunito(
                          color: Color.fromRGBO(80, 108, 251, 1),
                          fontSize: 12.sp),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to the desired screen when "SIGN UP" is tapped

                          Navigator.push(
                            context,
                            GetPageRoute(
                                page: () => Sign_Up(), binding: AuthBinding()),
                          );
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              _buildLineRow(),
              SizedBox(height: 15.h),
              Text("Continue with",
                  style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400)),
              SizedBox(height: 15.h),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    // if (!Platform.isAndroid) {
                    //   AuthenticationService().handleGoogleSignInApple(context);
                    // } else {
                    CustomEasyLoading.show();

                    AuthenticationService().handleGoogleSignInAndroid(context);
                    // }
                  },
                  child: Container(
                      height: 32.h,
                      width: 51.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.h, vertical: 7.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: CustomImageView(
                          imagePath: "assets/img_flat_color_icons_google.svg",
                          height: 25.sp,
                          width: 25.sp,
                          alignment: Alignment.center)),
                ),
                GestureDetector(
                  onTap: () {
                    print("hello");
                    AuthenticationService().handleFacebookSignIn(context);
                  },
                  child: Container(
                      height: 32.h,
                      width: 55.w,
                      margin: EdgeInsets.only(left: 16.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.h, vertical: 7.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: CustomImageView(
                          imagePath: "assets/img_logos_facebook.svg",
                          height: 27.sp,
                          width: 27.sp,
                          alignment: Alignment.center)),
                ),
                if (!Platform.isAndroid)
                  GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        "Coming Soon",
                        "Logged in with Apple.",
                        backgroundColor:
                            AppColors.burColor, // Use a static color
                        colorText: Colors.white,
                      );
                    },
                    child: Container(
                        height: 32.h,
                        width: 55.w,
                        margin: EdgeInsets.only(left: 16.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 7.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: CustomImageView(
                            imagePath: "assets/img_bxl_apple.svg",
                            height: 27.sp,
                            width: 27.sp,
                            alignment: Alignment.center)),
                  )
              ]),
              SizedBox(height: 5.h)
            ]))));
  }

  /// Section Widget

  Widget _buildSignInFrame(
      {required TextEditingController controller,
      required String selectedCountryCode}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Phone Number",
              style: GoogleFonts.nunito(
                  color: AppColors.textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 10.h),
          Row(
            children: [
              // Country Code Picker
              CountryCodePicker(
                textStyle: GoogleFonts.nunito(
                  fontSize: 12.sp,
                  color: AppColors.textColor,
                ),
                onChanged: (CountryCode? code) {
                  // Handle country code selection
                  countrycode = code!.dialCode.toString();
                },
                initialSelection: selectedCountryCode,
                favorite: [
                  '+1',
                  '+44',
                  '+92'
                ], // Optional: Specify your favorite country codes
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
              ),
              // Phone Number
              Expanded(
                child: CustomTextFormField(
                  controller: controller,
                  hintText: "Enter Phone number",
                  textInputType: TextInputType.phone,
                  autofocus: false,
                  textInputAction: TextInputAction.done,
                  textStyle: GoogleFonts.nunito(
                    fontSize: 12.sp,
                    color: AppColors.textColor,
                  ),
                  prefix: Container(
                    margin: EdgeInsets.fromLTRB(20.h, 14.w, 12.h, 14.w),
                    child: CustomImageView(
                      imagePath: "assets/img_mask_group.png",
                      height: 20.sp,
                      color: AppColors.textColor,
                      width: 20.sp,
                    ),
                  ),
                  prefixConstraints: BoxConstraints(maxHeight: 48.h),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPasswordFrame() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Password",
              style: GoogleFonts.nunito(
                  color: AppColors.textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 10.h),
          CustomTextFormField(
            controller: passwordController,
            hintText: "Enter password",
            autofocus: false,
            textStyle: GoogleFonts.nunito(
              fontSize: 12.sp,
              color: AppColors.textColor,
            ),
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(20.h, 14.h, 12.h, 14.h),
                child: CustomImageView(
                    imagePath: "assets/img_mask_group_20x20.png",
                    height: 18.sp,
                    color: AppColors.textColor,
                    width: 18.sp)),
            prefixConstraints: BoxConstraints(maxHeight: 48.h),
            suffix: GestureDetector(
                onTap: () {},
                child: Container(
                    margin: EdgeInsets.fromLTRB(30.h, 14.h, 20.h, 14.w),
                    child: CustomImageView(
                        imagePath: "assets/img_mask_group_1.png",
                        height: 17.sp,
                        color: AppColors.textColor,
                        width: 17.sp))),
            suffixConstraints: BoxConstraints(maxHeight: 48.h),
          ),
          SizedBox(height: 13.h),
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      GetPageRoute(
                          page: () => Forgetpassword(), binding: AuthBinding()),
                    );
                  },
                  child: Text("Forget Password?",
                      style: GoogleFonts.nunito(
                          color: Colors.black87,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300))))
        ]));
  }

  /// Section Widget
  Widget _buildLineRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(width: 120.h, child: Divider(color: Colors.black12)),
      SizedBox(
        width: 8.w,
      ),
      Text("or",
          style: GoogleFonts.nunito(
              color: AppColors.textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400)),
      SizedBox(
        width: 8.w,
      ),
      SizedBox(
          width: 120.h,
          child: Divider(
            color: Colors.black12,
          ))
    ]);
  }
}
