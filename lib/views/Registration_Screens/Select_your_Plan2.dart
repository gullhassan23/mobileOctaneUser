import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Registration_Screens/Add_Vechile/Add_Vehicle.dart';

class Select_Your_plan2 extends StatefulWidget {
  const Select_Your_plan2({super.key});

  @override
  State<Select_Your_plan2> createState() => _Select_Your_plan2State();
}

class _Select_Your_plan2State extends State<Select_Your_plan2> {
  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 4.h,
          ),
          child: Column(
            children: [
              RedText("Select your Plan"),
              SizedBox(height: 11.h),
              Container(
                width: 362.h,
                margin: EdgeInsets.symmetric(horizontal: 13.h),
                child: GreyText(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                 
                  
                ),
              ),
              SizedBox(height: 24.h),
           
              Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      margin: EdgeInsets.all(0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 100.h,
        width: 390.w,
        
        padding: EdgeInsets.symmetric(
          horizontal: 18.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 112.h,
                width: 390.w,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                      "Free Plan",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 18.sp,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                
                  Padding(
                    padding: EdgeInsets.only(
                      left: 150.w,
                      top: 2.h,
                      bottom: 2.w,
                    ),
                    child:  Text(
                       "\$500/m",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 312.h,
                margin: EdgeInsets.only(bottom: 1.h),
                child:  Text(
                    "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet , comsectetur elit.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 14.sp,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            
          ],
        ),
      ),
    ),
           SizedBox(height: 10.h,),
              Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      margin: EdgeInsets.all(0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 100.h,
        width: 390.w,
        
        padding: EdgeInsets.symmetric(
          horizontal: 18.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 112.h,
                width: 390.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                      "Fleet",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 18.sp,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                
                  Padding(
                    padding: EdgeInsets.only(
                      left: 190.w,
                      top: 2.h,
                      bottom: 2.w,
                    ),
                    child:  Text(
                       "\$25/m",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 312.h,
                margin: EdgeInsets.only(bottom: 1.h),
                child:  Text(
                    "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet , comsectetur elit.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 14.sp,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            
          ],
        ),
      ),
    ),
           SizedBox(height: 10.h,),
              Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      margin: EdgeInsets.all(0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 100.h,
        width: 390.w,
        
        padding: EdgeInsets.symmetric(
          horizontal: 18.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 112.h,
                width: 390.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                      "Dummy",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 18.sp,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                
                  Padding(
                    padding: EdgeInsets.only(
                      left: 160.w,
                      top: 2.h,
                      bottom: 2.w,
                    ),
                    child:  Text(
                       "\$25/m",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 312.h,
                margin: EdgeInsets.only(bottom: 1.h),
                child:  Text(
                    "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet , comsectetur elit.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 14.sp,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            
          ],
        ),
      ),
    ),
           
           
            ],
          ),
        ),
        bottomNavigationBar: _buildNext(),
      ),
    );
  }

  /// Section Widget
  // PreferredSizeWidget _buildAppBar() {
  //   return CustomAppBar(
  //     leadingWidth: double.maxFinite,
  //     leading: AppbarLeadingImage(
  //       imagePath: ImageConstant.imgMaskGroup24x24,
  //       margin: EdgeInsets.fromLTRB(20.h, 38.v, 386.h, 14.v),
  //     ),
  //     styleType: Style.bgFill,
  //   );
  // }

  /// Section Widget
  // Widget _buildUserProfile() {
  //   return Obx(
  //     () => ListView.separated(
  //       physics: NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       separatorBuilder: (
  //         context,
  //         index,
  //       ) {
  //         return SizedBox(
  //           height: 20.h,
  //         );
  //       },
  //       itemCount: controller
  //           .subscriptionPlanOneModelObj.value.userprofileItemList.value.length,
  //       itemBuilder: (context, index) {
  //         UserprofileItemModel model = controller.subscriptionPlanOneModelObj
  //             .value.userprofileItemList.value[index];
  //         return UserprofileItemWidget(
  //           model,
  //         );
  //       },
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildNext() {
    return CustomElevatedButton(
      
      text: "NEXT",
       onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Vehicle_screen()));
             },
      margin: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 50.h,
      ),
    );
  }
}

  
