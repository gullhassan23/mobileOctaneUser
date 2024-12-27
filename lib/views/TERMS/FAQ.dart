import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/Widgets/FAQContainer.dart';
import 'package:mobile_octane/global/refs.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Headline("FAQ"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: FAQRef.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text('No documents found.');
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var document = snapshot.data!.docs[index];
                      // Access document fields using document['field_name']
                      return Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.black),
                            ),
                            elevation: 0,
                            child: Theme(
                              data: ThemeData(dividerColor: Colors.transparent
                                  // dividerTheme: DividerThemeData().copyWith(borderSide: BorderSide.none),
                                  ),
                              child: ExpansionTile(
                                // tilePadding:
                                //     EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                collapsedBackgroundColor: AppColors
                                    .backgroundColor, // Adjust as needed
                                backgroundColor: AppColors.backgroundColor,
                                // Adjust as needed
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${document['question']}",
                                      style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    // SvgPicture.asset(
                                    //   "assets/img_arrow_down_2.svg",
                                    //   color: AppColors.burColor,
                                    // ),
                                  ],
                                ),
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Divider(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 15, left: 15, right: 15),
                                    child: Text(
                                      "${document['answer']}",
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.nunito(
                                          color: Colors.black45,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                expandedAlignment: Alignment.centerLeft,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
