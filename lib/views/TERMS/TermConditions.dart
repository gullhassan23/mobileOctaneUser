import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:flutter/services.dart';

import '../../global/refs.dart';
import '../Constrants/Colors.dart';

class TermConditions extends StatelessWidget {
  const TermConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Headline("Terms of Use"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: 10.w, top: 4.h, right: 10.w, bottom: 10.h),
                child: StreamBuilder(
                  stream: TandCRef.snapshots(),
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
                   
                    try {
                      print("success");

                   
                    } on PlatformException catch (e) {
                      print('Error: ${e.message}');
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var document = snapshot.data!.docs[index];
                        // Access document fields using document['field_name']
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${index + 1}. ${document['title']}",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.nunito(
                                  color: AppColors.textColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "${document['subtitle']}",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.nunito(
                                fontSize: 13.sp,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        );
                        // ListTile(
                        //   title: Text(document['title']),
                        //   subtitle: Text(document['subtitle']),
                        //   // Add more fields as needed
                        // );
                      },
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
