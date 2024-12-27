import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/Buttons.dart';
import '../../Widgets/CustomImageView.dart';
import '../../Widgets/appBar_title.dart';
import '../../Widgets/app_bar_leadingImage.dart';
import '../../Widgets/custom_app_bar.dart';
import '../../Widgets/custom_floating_button.dart';
import '../../Widgets/custom_search_view.dart';
import '../Constrants/Colors.dart';
import '../FillUpScreen/fill_up_screen.dart';

class add_location_screen extends StatefulWidget {
  const add_location_screen({super.key});

  @override
  State<add_location_screen> createState() => _add_location_screenState();
}

class _add_location_screenState extends State<add_location_screen> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: EdgeInsets.only(bottom: 40.h),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img_group_259.png"),
                    fit: BoxFit.cover)),
            child: SizedBox(
                width: double.maxFinite,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  _buildSettingAppBar(searchController,context),
                  Spacer(flex: 43),
                  CustomImageView(
                      imagePath: "assets/img_image_328.png",
                      height: 33.h,
                      width: 33.w),
                  Spacer(flex: 56)
                ]))),
        bottomNavigationBar: _buildNextButton(context),
        floatingActionButton: _buildFloatingActionButton());
  }
}
/// Section Widget
Widget _buildSettingAppBar(TextEditingController searchController,BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.burColor
    ),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        SizedBox(height: 15.h),
        CustomAppBar(
            height: 20.h,
            leadingWidth: 44.w,
            leading: AppbarLeadingImage(
                imagePath: "assets/img_mask_group_24x24.png",
                margin: EdgeInsets.only(left: 20.w, top: 2.h, bottom: 1.h),
                onTap: () {
                  Navigator.pop(context);
                  // onTapImage();
                }),
            centerTitle: true,
            title: AppbarTitle(text: "Add Location")),
        SizedBox(height: 18.h),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: CustomSearchView(
              hintStyle: GoogleFonts.nunito(
                fontSize: 13.sp,
                color: Colors.white

              ),
                autofocus: false,
                textStyle: GoogleFonts.nunito(
                    fontSize: 13.sp,
                    color: Colors.white

                ),
                controller: searchController,
                hintText: "Search Location"))
      ]));
}

/// Section Widget
Widget _buildNextButton(BuildContext context) {
  return CustomElevatedButton(
      text: "NEXT".toUpperCase(),
      margin: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 40.h),
      onPressed: () {
        // onTapNextButton();
        Navigator.push(context, MaterialPageRoute(builder: (context) => fill_up_screen()));
      });
}

/// Section Widget
Widget _buildFloatingActionButton() {
  return CustomFloatingButton(
      height: 40.h,
      width: 40.w,
      backgroundColor: Colors.white,
      child: CustomImageView(
          imagePath: "assets/img_contrast.svg",
          height: 22.0.h,
          color: Colors.black,
          width: 22.0.w));
}

