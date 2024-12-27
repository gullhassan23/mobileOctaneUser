import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/CustomImageView.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Dashboard/Setting/Change_password_2.dart';
import 'package:mobile_octane/views/Registration_Screens/OTP_screen.dart';
import 'package:xor_encryption/xor_encryption.dart';

import '../../../constant/strings.dart';
import '../../../services/services/user_services.dart';
import '../../Constrants/Colors.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserServices _userServices = Get.find<UserServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Headline('Change Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: 0.w, right: 0.w, top: 10.h, bottom: 10.h),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: Container(
                            width: 250.w,
                            child: GreyText(
                              "Lorem ipsum dolor sit , consectetur adipiscing elit.",
                              align: TextAlign.center,
                              fontsize: 13.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text("Current Password",
                            style: GoogleFonts.nunito(
                                color: AppColors.textColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 13.h),
                        CustomTextFormField(
                            // controller: controller.passwordController,
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
                                    imagePath:
                                        "assets/img_mask_group_20x20.png",
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
                                        imagePath:
                                            "assets/img_mask_group_1.png",
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
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 13.h)),
                        SizedBox(height: 13.h),
                      ],
                    )
                    ),
                    
                        SizedBox(height: 300.h),
                
                Container(
                    height: 35.h,
                    width: 300.w,
                    child: CustomElevatedButton(
                        text: "NEXT",
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Change_password2()),
                            );
                          }
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
