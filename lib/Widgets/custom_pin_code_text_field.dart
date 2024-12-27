import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPInputWidget extends StatefulWidget {
  final Function(String) onCompleted;

  OTPInputWidget({required this.onCompleted});

  @override
  _OTPInputWidgetState createState() => _OTPInputWidgetState();
}

class _OTPInputWidgetState extends State<OTPInputWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      controller: _controller,
      length: 4,
      keyboardType: TextInputType.number,
      textStyle: TextStyle(fontSize: 18.0, color: Colors.black),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      pinTheme: PinTheme(
        fieldHeight: 44.h,
        fieldWidth: 48.h,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10.h),
        selectedColor: Colors.grey,
        selectedFillColor: Colors.grey.withOpacity(0.4),
        inactiveColor: Colors.transparent,
        activeColor: Colors.transparent,
        borderWidth: 2,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
      ),
      onChanged: (value) {
        // Handle the OTP value change if needed
      },
      onCompleted: (value) {
        widget.onCompleted(value);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
