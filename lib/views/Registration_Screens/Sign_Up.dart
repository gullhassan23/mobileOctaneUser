import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Controller/user_controller.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/CustomImageView.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:mobile_octane/backend/auth.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Registration_Screens/OTP_screen.dart';

import '../../AuthenticationService/AuthenticationService.dart';
import '../../Controller/auth_controller.dart';
import '../../Widgets/toast.dart';
import '../../main.dart';
import '../../main3.dart';
import '../Constrants/Colors.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({super.key});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  AuthController _authController = Get.find<AuthController>();
  String countrycode = "+92";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          surfaceTintColor: Colors.transparent,
        ),
        //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
                child: Column(children: [
              SizedBox(height: 10.h),
              RedText(
                "Sign Up",
                color: AppColors.burColor,
              ),
              SizedBox(height: 45.h),
              _buildSignInFrame(
                  controller: _authController.phoneNumbercon,
                  selectedCountryCode: '+92'),
              SizedBox(
                height: 10.h,
              ),
              _buildPasswordFrame(
                  controller: _authController.passwordcon,
                  labelText: 'Password',
                  hintText: "Enter Password"),
              _buildPasswordFrame(
                  controller: _authController.confirmpasswordcon,
                  labelText: 'Confirm Password',
                  hintText: "Enter Confirm Password"),
              SizedBox(height: 20.h),
              CustomElevatedButton(
                  text: "SIGN UP",
                  margin: EdgeInsets.symmetric(horizontal: 20.h),
                  onPressed: () async {
                    // AuthenticationService authService = AuthenticationService();

                    authService.phoneNumber =
                        "${countrycode}${_authController.phoneNumbercon.text}"; // Replace with the actual phone number

                    print(
                        "confirm password = ${_authController.confirmpasswordcon.text}");
                    print("password = ${_authController.passwordcon.text}");
                    print(
                        "phoneNumber = ${countrycode} ${_authController.phoneNumbercon.text}");
                    if (_authController.phoneNumbercon.text == "") {
                      ToastWidget.showToast("Enter PhoneNumber");
                    } else if (_authController.passwordcon.text == "") {
                      ToastWidget.showToast("Enter Password");
                    } else if (_authController.confirmpasswordcon.text == "") {
                      ToastWidget.showToast("Enter Confirm Password");
                    } else if (_authController.passwordcon.text !=
                        _authController.confirmpasswordcon.text) {
                      ToastWidget.showToast("Password Doesnot Match");
                    } else {
                      authService
                          .isNumberInCollection(authService.phoneNumber)
                          .then((value) {
                        print("customer exist = ${value}");
                        if (value) {
                          Fluttertoast.showToast(msg: "User Already Exist");
                        } else {
                          authService.Forgetpass=false;
                          authService
                              .signInWithPhoneNumber(context)
                              .then((value) {
                            print("value = ${value}");
                            if (value == true) {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => OTPscreen()));
                            }
                          });
                        }
                      });
                    }
                  }),
              SizedBox(height: 10.h),
              RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Already have an account",
                      style: GoogleFonts.nunito(
                          color: Colors.black54, fontSize: 12.sp),
                    ),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                            // Handle the tap event here, e.g., navigate to the sign-in screen
                          },
                        text: " SIGN IN",
                        style: GoogleFonts.nunito(
                            color: Color.fromRGBO(80, 108, 251, 1),
                            fontSize: 12.sp))
                  ]),
                  textAlign: TextAlign.left),
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
                Container(
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
                Container(
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
                Container(
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
                        imagePath: "assets/img_bxl_apple.svg",
                        height: 27.sp,
                        width: 27.sp,
                        alignment: Alignment.center))
              ]),
              SizedBox(height: 5.h)
            ]))));
  }

  /// Section Widget

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
                  print(code!.dialCode.toString());
                  countrycode = code.dialCode.toString();
                  // Handle country code selection
                },
                initialSelection: selectedCountryCode,
                favorite: [
                  '+1',
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
                  // autofocus: false,

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
  Widget _buildPasswordFrame(
      {required TextEditingController controller,
      required String labelText,
      required String hintText}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${labelText}",
              style: GoogleFonts.nunito(
                  color: AppColors.textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 10.h),
          CustomTextFormField(
            controller: controller,
            hintText: "${hintText}",
            // autofocus: false,
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
