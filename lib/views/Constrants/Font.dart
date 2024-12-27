
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';




// Widget tabWidget(
//     String title,
//     bool selected, {
//       VoidCallback? ontap,
//       double width = 100,
//     }) {
//   return InkWell(
//     onTap: ontap,
//     child: Container(
//       width: width,
//       height: 35,
//       padding: const EdgeInsets.all(5),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: selected ? AppColors.backgroundColor : null,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: AppColors.backgroundColor),
//         boxShadow: selected
//             ? [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             blurRadius: 4,
//             spreadRadius: 0,
//             offset: const Offset(0, 4),
//           ),
//         ]
//             : null,
//       ),
//       child: BodyText(
//         title,
//         align: TextAlign.center,
//         color: selected ? Colors.white : AppColors.b,
//       ),
//     ),
//   );
// }

// Widget chartLabel() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         children: [
//           Expanded(child: indicator('On Hold', const Color(0xff5E3FBE))),
//           Expanded(child: indicator('Upcoming', const Color(0xffF4F0FD))),
//         ],
//       ),
//       indicator('Completed', const Color(0xffE5DAFB))
//           .marginOnly(bottom: 20, top: 5)
//     ],
//   );
// }

// Widget indicator(String title, Color color) {
//   return Row(
//     children: [
//       Icon(Icons.rectangle, color: color).marginOnly(right: 15),
//       BodyText(title),
//     ],
//   ).marginOnly(right: 10);
// }

// Widget fieldTitle(String title) {
//   return BodyText(
//     title,
//     fontsize: 13,
//     weight: FontWeight.w500,
//   ).marginOnly(bottom: 5);
// }




// EdgeInsetsGeometry get pageMargin =>
//     const EdgeInsets.symmetric(horizontal: 15, vertical: 10);

class Headline extends StatelessWidget {
  const Headline(
    this.text, {
    Key? key,
    this.fontsize,
    this.weight,
    this.color,
    this.align,
    this.maxline,
    this.overflow,
  }) : super(key: key);
  final String text;
  final double? fontsize;
  final Color? color;
  final TextAlign? align;
  final FontWeight? weight;
  final int? maxline;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxline,
      overflow: overflow,
      style: GoogleFonts.nunito(
        fontSize: fontsize ?? 20.sp,
        color: color ?? AppColors.burColor,
        fontWeight: weight ?? FontWeight.bold,
      ),
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText(
    this.text, {
    Key? key,
    this.fontsize,
    this.color,
    this.maxLines,
    this.overflow,
    this.align,
    this.weight,
    this.font,
    this.decoration,
    this.height,
    this.style,
  }) : super(key: key);
  final String text;
  final double? fontsize, height;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? align;
  final FontWeight? weight;
  final String? font;
  final TextDecoration? decoration;
  final FontStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.nunito( // Use GoogleFonts.poppins
        fontSize: fontsize ?? 14.sp,
        color: color ?? const Color(0xFF000000),
        fontWeight: weight ?? FontWeight.w600,
        decoration: decoration,
        decorationColor: Colors.white,
        decorationThickness: 2.0,
        height: height,
        fontStyle: style ?? FontStyle.normal,
      ),
    );
  }
}
class RedText extends StatelessWidget {
  const RedText(
    this.text, {
    Key? key,
    this.fontsize,
    this.color,
    this.maxLines,
    this.overflow,
    this.align,
    this.weight,
    this.font,
    this.decoration,
    this.height,
    this.style,
  }) : super(key: key);
  final String text;
  final double? fontsize, height;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? align;
  final FontWeight? weight;
  final String? font;
  final TextDecoration? decoration;
  final FontStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.nunito( // Use GoogleFonts.poppins
        fontSize: fontsize ?? 20.sp,
        color: color ?? Color(0xffE41B23),
        fontWeight: weight ?? FontWeight.w800,
        decoration: decoration,
       // decorationColor: Colors.white,
        decorationThickness: 2.0,
        height: height,
        fontStyle: style ?? FontStyle.normal,
      ),
    );
  }
}



class GreyText extends StatelessWidget {
  const GreyText(
    this.text, {
    Key? key,
    this.fontsize,
    this.color,
    this.maxLines,
    this.overflow,
    this.align,
    this.weight,
    this.font,
    this.decoration,
    this.height,
    this.style,
  }) : super(key: key);
  final String text;
  final double? fontsize, height;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? align;
  final FontWeight? weight;
  final String? font;
  final TextDecoration? decoration;
  final FontStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.nunito( // Use GoogleFonts.poppins
        fontSize: fontsize ?? 12.sp,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
        decoration: decoration,
       // decorationColor: Colors.white,
        //decorationThickness: 2.0,
        height: height,
        fontStyle: style ?? FontStyle.normal,
      ),
    );
  }
}


class AuthText extends StatelessWidget {
  const AuthText(
      {super.key, required this.title, required this.value, this.ontap});
  final String title, value;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: RichText(
        text: TextSpan(
          text: title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: AppColors.backgroundColor),
          children: [
            TextSpan(
              text: value,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
              recognizer: TapGestureRecognizer()..onTap = ontap,
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleText extends StatelessWidget {
  const SimpleText(
    this.text, {
    Key? key,
    this.fontsize,
    this.color,
    this.maxLines,
    this.overflow,
    this.align,
    this.weight,
    this.font,
    this.decoration,
    this.height,
    this.style,
  }) : super(key: key);
  final String text;
  final double? fontsize, height;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? align;
  final FontWeight? weight;
  final String? font;
  final TextDecoration? decoration;
  final FontStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.nunito( // Use GoogleFonts.poppins
        fontSize: fontsize ?? 13.sp,
        color: color ?? const Color(0xFF000000),
        fontWeight: weight ?? FontWeight.w500,
        decoration: decoration,
        height: height,
        fontStyle: style ?? FontStyle.normal,
        letterSpacing: -0.6
      ),
    );
  }
}


class WhiteText extends StatelessWidget {
  const WhiteText(
    this.text, {
    Key? key,
    this.fontsize,
    this.weight,
    this.color,
    this.align,
    this.font,
    this.maxline,
    this.overflow,
  }) : super(key: key);
  final String text;
  final double? fontsize;
  final Color? color;
  final TextAlign? align;
  final String? font;
  final FontWeight? weight;
  final int? maxline;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxline,
      overflow: overflow,
      style: GoogleFonts.nunito( // Use GoogleFonts.poppins
        fontSize: fontsize ?? 18.sp,
        color: color ?? Colors.white,
        fontWeight: weight ?? FontWeight.bold,
      ),
    );
  }
}