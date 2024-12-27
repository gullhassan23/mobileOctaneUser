import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CustomImageView.dart';

class CustomSearchView extends StatelessWidget {
  CustomSearchView({
    Key? key,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChanged,
  }) : super(
    key: key,
  );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: searchViewWidget,
    )
        : searchViewWidget;
  }

  Widget get searchViewWidget => SizedBox(
    width: width ?? double.maxFinite,
    child: TextFormField(
      // scrollPadding: EdgeInsets.only(
      //     bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
      controller: controller,
      focusNode: focusNode ?? FocusNode(),
      autofocus: autofocus!,
      style: textStyle,
      keyboardType: textInputType,
      maxLines: maxLines ?? 1,
      decoration: decoration,
      validator: validator,
      onChanged: (String value) {
        onChanged!.call(value);
      },
    ),
  );
  InputDecoration get decoration => InputDecoration(
    hintText: hintText ?? "",
    hintStyle: hintStyle,
    prefixIcon: prefix ??
        Container(
          margin: EdgeInsets.fromLTRB(12.w, 12.h, 20.w, 12.h),
          child: CustomImageView(
            imagePath: "assets/img_mask_group_16x16.png",
            height: 14.h,
            width: 14.w,
          ),
        ),
    prefixIconConstraints: prefixConstraints ??
        BoxConstraints(
          maxHeight: 40.h,
        ),
    suffixIcon: suffix ??
        Padding(
          padding: EdgeInsets.only(
            right: 15.h,
          ),
          child: IconButton(
            onPressed: () => controller!.clear(),
            icon: Icon(
              Icons.clear,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
        ),
    suffixIconConstraints: suffixConstraints ??
        BoxConstraints(
          maxHeight: 40.h,
        ),
    isDense: true,
    contentPadding: contentPadding ??
        EdgeInsets.only(
          top: 9.h,
          right: 9.w,
          bottom: 9.h,
        ),
    fillColor: fillColor ?? Color(0X4C252525),
    filled: filled,
    border: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.h),
          borderSide: BorderSide.none,
        ),
    enabledBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.h),
          borderSide: BorderSide.none,
        ),
    focusedBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.h),
          borderSide: BorderSide.none,
        ),
  );
}
