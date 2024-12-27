import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/Widgets/CustomImageView.dart';
import 'package:mobile_octane/Widgets/custom_text_form_field.dart';
import 'package:mobile_octane/Widgets/shimmer.dart';
import 'package:mobile_octane/Widgets/toast.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Dashboard/Home/Fill_Up/Fill_up_2.dart';

import '../../../../Controller/addfuelController.dart';
import '../../../../Model/fuel_model.dart';
import '../../../../global/refs.dart';
import '../../../../map.dart';
import '../../../AddLocationScreen/add_location_screen.dart';
import '../../../Constrants/Colors.dart';

class Fill_Up_1 extends StatefulWidget {
  const Fill_Up_1({super.key});

  @override
  State<Fill_Up_1> createState() => _Fill_Up_1State();
}

class _Fill_Up_1State extends State<Fill_Up_1> {
  String? selectedFuel;
  // Fuel? _addFuelController.selectfuel;
  // TimeOfDay? selectedTime;
  // TextEditingController timeController = TextEditingController();
  // TextEditingController fuellitterController = TextEditingController();
  // TextEditingController pricefuelController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddFuelController _addFuelController = Get.find<AddFuelController>();
  bool enterprice = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // bool isChecked = false;
  // bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          surfaceTintColor: Colors.transparent,
          title: Headline("Fill Up"),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.only(
                top: 20.h, bottom: 10.h, left: 15.h, right: 15.h),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing rlit. Vestibility edge felis tellus",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                fontSize: 13.sp,
                                color: Colors.black38,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                letterSpacing: -0.2)),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select Time",
                              style: GoogleFonts.nunito(
                                  color: AppColors.textColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 10.h),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              _selectTime(context);
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: CustomTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Select Time';
                                  }
                                  // Add additional validation rules as needed
                                  return null;
                                },
                                controller: _addFuelController.timeController,
                                hintText: "hh/mm",
                                textInputType: TextInputType.phone,
                                textStyle: GoogleFonts.nunito(
                                  fontSize: 12.sp,
                                  color: AppColors.textColor,
                                ),
                                prefix: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      20.h, 14.w, 12.h, 14.w),
                                  child: CustomImageView(
                                    imagePath: "assets/img_mask_group_4.png",
                                    height: 20.sp,
                                    color: AppColors.textColor,
                                    width: 20.sp,
                                  ),
                                ),
                                prefixConstraints:
                                    BoxConstraints(maxHeight: 48.h),
                              ),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 100.h,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: fuelRef.snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return shimmerwidget(
                                  height: 40.h,
                                  count: 2,
                                );
                              }
                              if (snapshot.hasData) {
                                var fuels = snapshot.data!.docs;
                                print("ffffff ${fuels}");

                                return ListView.builder(
                                  itemCount: fuels.length,
                                  itemBuilder: (context, index) {
                                    var fuel = fuels[index];
                                    var fuelDetails = Fuel.fromMap(
                                        fuel.data() as Map<String, dynamic>);

                                    return Column(
                                      children: [
                                        InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              setState(() {
                                                selectedFuel = fuel['name'];
                                                _addFuelController
                                                    .selectedFuel = fuelDetails;
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0),
                                                    color: selectedFuel ==
                                                            fuel['name']
                                                        ? Colors.red
                                                        : Colors.white,
                                                    border: Border.all(
                                                      color: selectedFuel ==
                                                              fuel['name']
                                                          ? Colors.red
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                  child: selectedFuel ==
                                                          fuel['name']
                                                      ? Image.asset(
                                                          "assets/img_mask_group_12x12.png")
                                                      : Container(),
                                                ),
                                                SizedBox(width: 20),
                                                Text(fuel['name'],
                                                    style: GoogleFonts.nunito(
                                                        fontSize: 14.sp,
                                                        color: const Color(
                                                            0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        letterSpacing: -0.6)),
                                              ],
                                            )),
                                        SizedBox(height: 20.h),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                        if (enterprice == false)
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Litter",
                                    style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(height: 10.h),
                                CustomTextFormField(
                                  controller:
                                      _addFuelController.fuellitterController,
                                  hintText: "Enter number of litter",
                                  textInputType: TextInputType.phone,
                                  textStyle: GoogleFonts.nunito(
                                    fontSize: 12.sp,
                                    color: AppColors.textColor,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter number of litter';
                                    }
                                    // Add additional validation rules as needed
                                    return null;
                                  },
                                  prefix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          20.h, 14.w, 12.h, 14.w),
                                      child: CustomImageView(
                                          imagePath:
                                              "assets/img_mask_group_5.png",
                                          height: 20.sp,
                                          color: AppColors.textColor,
                                          width: 20.sp)),
                                  prefixConstraints:
                                      BoxConstraints(maxHeight: 48.h),
                                )
                              ]),
                        if (enterprice == true)
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Price",
                                    style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(height: 13.h),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 90.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: TextFormField(
                                            controller: _addFuelController
                                                .pricefuelController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please Enter Amount';
                                              }
                                              // Add additional validation rules as needed
                                              return null;
                                            },
                                            cursorColor: Colors.transparent,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            // maxLength: 5,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(
                                                      r'[0-9.]')), // Allow digits and dot (.)
                                            ],
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'Enter amount', // Placeholder text
                                              hintStyle: TextStyle(
                                                color: Colors.green,
                                                fontSize: 24.0,
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontSize: 32.0,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: -0.2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        SizedBox(
                          height: 20.h,
                        ),
                        if (enterprice == false)
                          InkWell(
                            onTap: () {
                              enterprice = true;
                              setState(() {});
                              _addFuelController.fuellitterController.clear();
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Enter custom price",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16.sp,
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: -0.6)),
                            ),
                          ),
                        if (enterprice == true)
                          InkWell(
                            onTap: () {
                              enterprice = false;
                              _addFuelController.pricefuelController.clear();

                              setState(() {});
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Enter Litter",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16.sp,
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: -0.6)),
                            ),
                          ),
                        SizedBox(
                          height: 20.h,
                        ),

                        // SizedBox(
                        //   height: 100.h,
                        // ),
                        CustomElevatedButton(
                            text: "NEXT",
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                if (selectedFuel == null) {
                                  ToastWidget.showToast("Please Select Fuel");
                                } else {
                                  // print(selectedFuel);

                                  // print(_addFuelController.selectedFuel);
                                  // print(_addFuelController
                                  //     .fuellitterController.text);

                                  // print(_addFuelController.timeController.text);
                                  // print(_addFuelController
                                  //     .pricefuelController.text);

                                  if (enterprice == true) {
                                    double amount = double.parse(
                                        _addFuelController
                                            .pricefuelController.text
                                            .toString());
                                    double pricePerLiter = _addFuelController
                                        .selectedFuel!.pricePerLiter;
                                    double liters = amount / pricePerLiter;
                                    _addFuelController.totalliter = liters;
                                    _addFuelController.totalprice = amount;
                                    print('pricePerLiter: $pricePerLiter');

                                    print(
                                        'Amount: ${_addFuelController.totalprice}');
                                    print(
                                        'Litersss: ${_addFuelController.totalliter}');
                                  } else {
                                    double liters = double.parse(
                                        _addFuelController
                                            .fuellitterController.text
                                            .toString());

                                    double pricePerLiter = _addFuelController
                                        .selectedFuel!.pricePerLiter;
                                    double amount = liters * pricePerLiter;
                                    _addFuelController.totalprice = amount;

                                    _addFuelController.totalliter = liters;
                                    print('pricePerLiter: $pricePerLiter');

                                    print(
                                        'Amount: ${_addFuelController.totalprice}');
                                    print(
                                        'Litersss: ${_addFuelController.totalliter}');
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MapScreen()));
                                }
                              }
                            })
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _addFuelController.selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _addFuelController.selectedTime) {
      setState(() {
        _addFuelController.selectedTime = picked;
        _addFuelController.timeController.text =
            "${picked.hour}/${picked.minute}";
        print("Selected time: ${_addFuelController.timeController.text}");
      });
    }
  }
}
