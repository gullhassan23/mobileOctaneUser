import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/CustomImageView.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/DeleteAccount/OTPdeleteAccount.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:xor_encryption/xor_encryption.dart';

import '../../Widgets/toast.dart';
import '../../constant/strings.dart';
import '../../main.dart';
import '../../main3.dart';
import '../../services/services/user_services.dart';

class DeleteAccount extends StatefulWidget {
  DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  String countrycode = "+92";

  TextEditingController phoneNumbercon = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  UserServices _userServices = Get.find<UserServices>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          surfaceTintColor: Colors.transparent,
          title: Headline("Delete Account"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 15.h,
            top: 15.h,
            right: 15.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/img_video_camera.svg",
                      color: AppColors.burColor,
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    Text(
                      "Delete your account will:",
                      style: GoogleFonts.nunito(
                          fontSize: 19.sp,
                          color: AppColors.burColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "We're sorry to see you go. If you're sure you want to delete your My Discountaccount, please be aware that this action is permanent and cannot be undone. All of your personal information, including your Furvana and settings, will be permanently deleted.",
                  style: GoogleFonts.nunito(
                      fontSize: 15.sp, color: Colors.black54),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "If you're having trouble with your account or have concerns, please reach out to us at [contact email or support page] before proceeding with the account deletion. We'd love to help you resolve any issues and keep you as a valued Furvana user.",
                  style: GoogleFonts.nunito(
                      fontSize: 15.sp, color: Colors.black54),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // _buildSignInFrame(
                      //     controller: phoneNumbercon,
                      //     selectedCountryCode: '+92'),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      CustomTextFormField(
                          controller: passwordController,
                          hintText: "Enter Current Password",
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          autofocus: false,
                          textStyle: GoogleFonts.nunito(
                            fontSize: 12.sp,
                            color: AppColors.textColor,
                          ),
                          prefix: Container(
                              margin:
                                  EdgeInsets.fromLTRB(20.h, 14.h, 12.h, 14.h),
                              child: CustomImageView(
                                  imagePath: "assets/img_mask_group_20x20.png",
                                  height: 20.sp,
                                  color: AppColors.textColor,
                                  width: 20.sp)),
                          prefixConstraints: BoxConstraints(maxHeight: 48.h),
                          suffix: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      30.h, 14.h, 20.h, 14.w),
                                  child: CustomImageView(
                                      imagePath: "assets/img_mask_group_1.png",
                                      height: 20.sp,
                                      color: AppColors.textColor,
                                      width: 20.sp))),
                          suffixConstraints: BoxConstraints(maxHeight: 48.h),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Current Password';
                            } else {
                              print("else");
                              print(" value =  $value");
                              String pass = XorCipher().encryptData(
                                  _userServices.customer.password.toString(),
                                  AppStrings.xorkey);
                              print(value != pass);
                              if (value != pass) {
                                return 'Please Enter Correct Password';
                              }
                            }
                            // Add additional validation rules as needed
                            return null;
                          },
                          //obscureText: controller.isShowPassword.value,
                          contentPadding: EdgeInsets.symmetric(vertical: 13.h)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "To delete your account, please enter your password in the field below and confirm your decision by clicking the 'Delete My Account' button.",
                  style: GoogleFonts.nunito(
                      fontSize: 16.sp, color: Colors.black54),
                ),
                SizedBox(
                  height: 38.h,
                ),
                CustomElevatedButton(
                    text: "DELETE ACCOUNT",
                    margin: EdgeInsets.symmetric(horizontal: 30.h),
                    onPressed: () {
                      authService.deleteaccount=true;
                      authService.phoneNumber =
                          "${_userServices.customer!.phone}"; // Replace with the actual phone number
                      if (_formKey.currentState?.validate() ?? false) {
                        authService.Forgetpass=true;
                        authService
                            .signInWithPhoneNumber(context)
                            .then((value) {
                          print("value = ${value}");
                          if (value == true) {
                          }
                        });
                      }
                    }),
              ],
            ),
          ),
        ));
  }

  Widget _buildSignInFrame(
      {required TextEditingController controller,
      required String selectedCountryCode}) {
    return Padding(
      padding: EdgeInsets.only(right: 5),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Phone number';
                    } else {
                      print("else");
                      print(" value =  $value");
                      String pass = XorCipher().encryptData(
                          _userServices.customer.password.toString(),
                          AppStrings.xorkey);
                      print(value != pass);
                      if (value != pass) {
                        return 'Please Enter Correct Password';
                      }
                    }
                    // Add additional validation rules as needed
                    return null;
                  },
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
