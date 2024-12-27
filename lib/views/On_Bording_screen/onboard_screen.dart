import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/Buttons.dart';
import 'package:mobile_octane/views/Registration_Screens/Sign_In.dart';

class Onboarding_Screen extends StatefulWidget {
  const Onboarding_Screen({super.key});

  @override
  State<Onboarding_Screen> createState() => _Onboarding_ScreenState();
}

class _Onboarding_ScreenState extends State<Onboarding_Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
            // extendBody: true,
            //extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: AssetImage("assets/img_onboarding_screen.png"),
                        fit: BoxFit.cover)),
                child: SizedBox(
                    width: double.maxFinite,
                    child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.5, 0),
                            end: Alignment(0.5, 1),
                            colors: [
                              Colors.black.withOpacity(0.21),
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 10.w, right: 10.w, bottom: 20.h),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Text(
                                  "Welcome to Mobile Octane",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 19.h),
                                Text(
                                  "Lorem ipsum sit amet, consectetur adipsing elit. Vestibilum eget felis nulla in massa pulvina orci laoreet macimus quiz a augue.",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 58.h),
                                CustomElevatedButton(
                                    width: 300.w,
                                    text: "NEXT",
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Sign_In()));
                                    })
                              ]),
                        ))))));
  }
}
