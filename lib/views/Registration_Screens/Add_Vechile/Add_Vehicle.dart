import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:flutter/material.dart';
import 'package:mobile_octane/views/My_Vehicles/My_Vehicles.dart';

import '../../../Model/vehicle_model.dart';
import '../../../Widgets/shimmer.dart';
import '../../../backend/auth.dart';
import '../../../global/refs.dart';
import '../../../main.dart';
import '../../../main3.dart';
import '../../../services/services/user_services.dart';
import '../../Constrants/Colors.dart';

// ignore_for_file: must_be_immutable
class Add_Vehicle_screen extends StatefulWidget {
  const Add_Vehicle_screen({super.key});

  @override
  State<Add_Vehicle_screen> createState() => _Add_Vehicle_screenState();
}

class _Add_Vehicle_screenState extends State<Add_Vehicle_screen> {
  TextEditingController vehiclecolorcon = TextEditingController();
  TextEditingController vehiclenamecon = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController Licenceplatenumbercon = TextEditingController();
  TextEditingController yearcon = TextEditingController();
  TextEditingController makecon = TextEditingController();
  TextEditingController modelcon = TextEditingController();
  UserServices _userServices = Get.find<UserServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(241, 229, 203, 1),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(241, 229, 203, 1),
          surfaceTintColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
                key: _formKey,
                child: SizedBox(
                    width: double.maxFinite,
                    child: Column(children: [
                      //_buildSkipSection(),
                      SizedBox(height: 1.h),
                      RedText(
                        "Add Vehicle",
                        color: AppColors.burColor,
                      ),
                      SizedBox(height: 20.h),
                      _buildFrame(
                          hintText: 'Enter Vehicles Name',
                          controller: vehiclenamecon,
                          labelText: 'Vehicle Name'),
                      // _buildAddVehicleColorSection(),
                      SizedBox(height: 10.h),
                      _buildFrame(
                          hintText: 'Enter Vehicles color',
                          controller: vehiclecolorcon,
                          labelText: 'Vehicle Color'),
                      // _buildAddVehicleColorSection(),
                      SizedBox(height: 10.h),
                      _buildFrame(
                          labelText: 'Licence Plate Number',
                          controller: Licenceplatenumbercon,
                          hintText: 'Enter Licence Number'),

                      // _buildLicensePlateNumberSection(),
                      SizedBox(height: 10.h),
                      _buildFrame(
                          labelText: 'Year',
                          controller: yearcon,
                          hintText: 'Enter Year'),

                      // _buildYearSection(),
                      SizedBox(height: 10.h),
                      _buildFrame(
                        
                          labelText: 'Make',
                          controller: makecon,
                          hintText: 'Enter Make'),

                      // _buildMakeSection(),
                      SizedBox(height: 10.h),
                      _buildFrame(
                          labelText: 'Model',
                          controller: modelcon,
                          hintText: 'Enter Model'),

                      // _buildModelSection(),
                      SizedBox(height: 10.h)
                    ])))),
        bottomNavigationBar: CustomElevatedButton(
            text: "ADD VEHICLES",
            margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 50.h),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                CustomEasyLoading.show();

                // Adding new data
                String docid = vehicleRef.doc().id;
                VehicleDetails newVehicleDetails = VehicleDetails(
                  id: docid, // leave empty for Firebase to generate an ID
                  vehicleColor: vehiclecolorcon.text,
                  licensePlateNumber: Licenceplatenumbercon.text,
                  year: yearcon.text,
                  make: makecon.text,
                  model: modelcon.text, created: DateTime.now(),
                  vehiclename: '${vehiclenamecon.text}',
                );
                checkUserLogin().then((value) {
                  print(value);
                  vehicleRef
                      .doc(value
                          ? FirebaseAuth.instance.currentUser!.uid
                          : _userServices.customer.id)
                      .collection("vehicles")
                      .doc(docid)
                      .set(newVehicleDetails.toMap())
                      .then((value) {
                    CustomEasyLoading.dismiss();
                    Navigator.pop(context);
                  });
                });
              }
            }
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => My_Vehicle()));
            ));
  }

  Widget _buildFrame({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$labelText",
            style: GoogleFonts.nunito(
              color: AppColors.textColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          CustomTextFormField(
            hintText: "${hintText}",
            controller: controller,
            textInputType: labelText.toLowerCase() == "year"
            //  ||
            //         labelText.toLowerCase() == "make" ||
            //         labelText.toLowerCase() == "model"
                ? TextInputType.number
                : TextInputType.text,
            prefixConstraints: BoxConstraints(maxHeight: 48.h),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please $hintText';
              }
              // Add additional validation rules as needed
              return null;
            },
          ),
        ],
      ),
    );
  }

  /// Section Widget
  // Widget _buildFrame(
  //     {required TextEditingController controller, required String hintText,required String labelText}) {
  //   return Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 20.h),
  //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //           Text("$labelText",
  //             style: GoogleFonts.nunito(
  //                 color: AppColors.textColor,
  //                 fontSize: 14.sp,
  //                 fontWeight: FontWeight.w600)),
  //         SizedBox(height: 10.h),
  //         CustomTextFormField(
  //           hintText: "${hintText}",
  //           controller: controller,
  //           textInputType: TextInputType.text,

  //           prefixConstraints: BoxConstraints(maxHeight: 48.h),
  //          contentPadding:
  //                 EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h)

  //         )
  //       ]));
  // }

  /// Section Widget
  // Widget _buildAddVehicleColorSection() {
  //   return Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 20.h),
  //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //         Text("Vehicle Color",
  //             style: GoogleFonts.nunito(
  //                 color: AppColors.textColor,
  //                 fontSize: 14.sp,
  //                 fontWeight: FontWeight.w600)),
  //         SizedBox(height: 10.h),
  //         CustomTextFormField(
  //             //controller: controller.entermodelController,
  //             hintText: "Enter Vehicles color",
  //             autofocus: false,
  //             textInputAction: TextInputAction.done,
  //             textStyle: GoogleFonts.nunito(
  //                 fontSize: 12.sp
  //             ),
  //             contentPadding:
  //                 EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h))
  //       ]));
  // }

  // /// Section Widget
  // Widget _buildLicensePlateNumberSection() {
  //   return Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 20.h),
  //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //         Text("Licence Plate Number",
  //             style: GoogleFonts.nunito(
  //                 color: AppColors.textColor,
  //                 fontSize: 14.sp,
  //                 fontWeight: FontWeight.w600)),
  //         SizedBox(height: 10.h),
  //         CustomTextFormField(
  //             //controller: controller.entermodelController,
  //             hintText: "Enter Licence Number",
  //             autofocus: false,
  //             textInputAction: TextInputAction.done,
  //             textStyle: GoogleFonts.nunito(
  //                 fontSize: 12.sp
  //             ),
  //             contentPadding:
  //                 EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h))
  //       ]));
  // }

  // /// Section Widget
  // Widget _buildYearSection() {
  //   return Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 20.h),
  //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //         Text("Year",
  //             style: GoogleFonts.nunito(
  //                 color: AppColors.textColor,
  //                 fontSize: 14.sp,
  //                 fontWeight: FontWeight.w600)),
  //         SizedBox(height: 10.h),
  //         CustomTextFormField(
  //             //controller: controller.entermodelController,
  //             hintText: "Enter Year",
  //             autofocus: false,
  //             textInputAction: TextInputAction.done,
  //             textStyle: GoogleFonts.nunito(
  //                 fontSize: 12.sp
  //             ),
  //             contentPadding:
  //                 EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h))
  //       ]));
  // }

  // /// Section Widget
  // Widget _buildMakeSection() {
  //   return Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 20.h),
  //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //         Text("Make",
  //             style: GoogleFonts.nunito(
  //                 color: AppColors.textColor,
  //                 fontSize: 14.sp,
  //                 fontWeight: FontWeight.w600)),
  //         SizedBox(height: 10.h),
  //         CustomTextFormField(
  //             //controller: controller.entermodelController,
  //             hintText: "Enter Make",
  //             autofocus: false,
  //             textInputAction: TextInputAction.done,
  //             textStyle: GoogleFonts.nunito(
  //                 fontSize: 12.sp
  //             ),
  //             contentPadding:
  //                 EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h))
  //       ]));
  // }

  // /// Section Widget
  // Widget _buildModelSection() {
  //   return Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 20.h),
  //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //         Text("Model ",
  //             style: GoogleFonts.nunito(
  //                 color: AppColors.textColor,
  //                 fontSize: 14.sp,
  //                 fontWeight: FontWeight.w600)),
  //         SizedBox(height: 10.h),
  //         CustomTextFormField(
  //             //controller: controller.entermodelController,
  //             hintText: "Enter Model",
  //             autofocus: false,
  //             textInputAction: TextInputAction.done,
  //             textStyle: GoogleFonts.nunito(
  //                 fontSize: 12.sp
  //             ),
  //             contentPadding:
  //                 EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h))
  //       ]));
  // }

  /// Navigates to the myVehiclesThreeScreen when the action is triggered.
}
