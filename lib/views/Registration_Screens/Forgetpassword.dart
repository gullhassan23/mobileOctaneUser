import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/CustomImageView.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Registration_Screens/OTP_screen.dart';

import '../../AuthenticationService/AuthenticationService.dart';
import '../../Controller/auth_controller.dart';
import '../../Widgets/toast.dart';
import '../../main.dart';
import '../../main3.dart';
import '../Constrants/Colors.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  AuthController _authController = Get.find<AuthController>();

  String countrycode = "+92";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: 0.w, right: 0.w, top: 10.h, bottom: 10.h),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: RedText(
                    "Forget Password",
                    color: AppColors.burColor,
                  )),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 290.w,
                child: GreyText(
                  "Please enter the phone number associated with your account.",
                  align: TextAlign.center,
                ),
              ),
              SizedBox(height: 40.h),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _buildSignInFrame(
                    controller: _authController.phoneNumbercon,
                    selectedCountryCode: '+92'),
                SizedBox(
                  height: 10.h,
                ),
              ]),
              SizedBox(
                height: 300.h,
              ),
              Container(
                  width: 300.w,
                  child: CustomElevatedButton(
                      text: "SEND OTP",
                      onPressed: () {
                        authService.phoneNumber =
                            "${countrycode}${_authController.phoneNumbercon.text}"; // Replace with the actual phone number

                        print(
                            "phoneNumber = ${countrycode} ${_authController.phoneNumbercon.text}");
                        if (_authController.phoneNumbercon.text == "") {
                          ToastWidget.showToast("Enter PhoneNumber");
                        } else {
                          authService.Forgetpass = true;
                          authService
                              .isNumberInCollection(authService.phoneNumber)
                              .then((value) {
                                    print("value = ${value}");
                            if (value) {
                              authService
                                  .signInWithPhoneNumber(context)
                                  .then((value) {
                            
                                if (value == true) {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => OTPscreen()));
                                }
                              });
                            } else {
                              Fluttertoast.showToast(msg: "User Not Exist");
                            }
                          });
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => OTPscreen()),
                        // );
                      })),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInFrame(
      {required TextEditingController controller,
      required String selectedCountryCode}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Phone Number",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontFamily: 'Nunito',
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
}
