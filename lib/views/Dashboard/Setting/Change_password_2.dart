import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/CustomImageView.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:mobile_octane/global/refs.dart';
import 'package:mobile_octane/services/services/user_services.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Registration_Screens/OTP_screen.dart';
import 'package:xor_encryption/xor_encryption.dart';

import '../../../constant/strings.dart';
import '../../Constrants/Colors.dart';
import '../Home/HomeScreen.dart';

class Change_password2 extends StatefulWidget {
  const Change_password2({super.key});

  @override
  State<Change_password2> createState() => _Change_password2State();
}

class _Change_password2State extends State<Change_password2> {
  TextEditingController passwordcon = TextEditingController();
  TextEditingController confirmpasswordcon = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserServices _userServices = Get.find<UserServices>();

  bool isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          surfaceTintColor: Colors.transparent,
          title: Headline("Change Password"),
        ),
        //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  GreyText(
                    "Create a New Password for Your Account",
                    color: Colors.black54,
                  ),
                  SizedBox(height: 50.h),
                  _buildPasswordFrame(
                    controller: passwordcon,
                    label: 'New Password',
                    hint: 'Enter Password',
                  ),
                  _buildPasswordFrame(
                    controller: confirmpasswordcon,
                    label: 'Confirm New Password',
                    hint: 'Enter Password',
                  ),
                  SizedBox(height: 210.h),
                  CustomElevatedButton(
                      text: "CHANGE PASSWORD",
                      margin: EdgeInsets.symmetric(horizontal: 20.h),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          String pass = XorCipher()
                              .encryptData(passwordcon.text, AppStrings.xorkey);
                          print(pass);
                          customersRef
                              .doc(_userServices.customer.id)
                              .update({"password": "${pass}"}).then((value) {
                            //                         Navigator.push(
                            // context, MaterialPageRoute(builder: (context) => Homescreen()));
                            Fluttertoast.showToast(
                              msg:
                                  'Congratulations! Password changed successfully.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: AppColors.Button1,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homescreen()),
                              (route) => false,
                            );
                          });
                        }
                      }),
                  SizedBox(height: 10.h),
                ],
              ),
            )));
  }

  /// Section Widget

  /// Section Widget
  Widget _buildPasswordFrame(
      {required TextEditingController controller,
      required String label,
      required String hint}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("$label",
              style: GoogleFonts.nunito(
                  color: AppColors.textColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 10.h),
          CustomTextFormField(
            controller: controller,
            hintText: "$hint",
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            // autofocus: false,
            textStyle: GoogleFonts.nunito(
              fontSize: 12.sp,
              color: AppColors.textColor,
            ),
            prefix: Container(
                margin: EdgeInsets.fromLTRB(20.h, 14.h, 12.h, 14.h),
                child: CustomImageView(
                    imagePath: "assets/img_mask_group_20x20.png",
                    height: 20.sp,
                    color: AppColors.textColor,
                    width: 20.sp)),
            prefixConstraints: BoxConstraints(maxHeight: 48.h),
            suffix: GestureDetector(
                onTap: () {
                  isShowPassword = !isShowPassword;
                  setState(() {});
                },
                child: Container(
                    margin: EdgeInsets.fromLTRB(30.h, 14.h, 20.h, 14.w),
                    child: CustomImageView(
                        imagePath: "assets/img_mask_group_1.png",
                        height: 20.sp,
                        color: AppColors.textColor,
                        width: 20.sp))),
            suffixConstraints: BoxConstraints(maxHeight: 48.h),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter $label';
              } else if (confirmpasswordcon.text != passwordcon.text) {
                return 'Password not match';
              }
            },
            obscureText: isShowPassword,
          ),
          SizedBox(height: 13.h),
        ]));
  }
}
