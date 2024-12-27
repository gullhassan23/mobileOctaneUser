import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shimmer/shimmer.dart';

import '../views/Constrants/Colors.dart';

class shimmerwidget extends StatelessWidget {
  final double height;
  int count ;

  shimmerwidget({
    required this.height,
    this.count=4,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey[300]!,
        child: ListView.builder(
          itemCount: count, // Change this based on the number of shimmering containers
          itemBuilder: (context, index) {
            return Column(
              children: [
                _buildContainer(height),
                SizedBox(height: 16.0),
              ],
            );
          },
        ),
      ),
    );
  }

  // Define a function to create a container with common properties
  Container _buildContainer(double height) {
    return Container(
      width: 350.w,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

  Future<void> showPermissionDeniedDialog(BuildContext context) async {
    // You can customize the dialog as needed
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Denied'),
          content: Text('To use this app, please enable location permission in settings.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Redirect user to app settings
                Geolocator.openAppSettings();
              },
              child: Text('Go to Settings'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showPermissionDeniedForeverDialog(BuildContext context) async {
    // You can customize the dialog as needed
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Denied Forever'),
          content: Text('To use this app, please enable location permission in settings.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Redirect user to app settings
                Geolocator.openAppSettings();
              },
              child: Text('Go to Settings'),
            ),
          ],
        );
      },
    );
  }
class CustomEasyLoading {
  static void init() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 30.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..textStyle = TextStyle(fontSize: 16.0, color: Colors.white)
      ..maskColor = Colors.black.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = true;
  }

  static void show() {
    EasyLoading.show(
      status: 'Loading...',
      indicator: CircularProgressIndicator(
        color: AppColors.burColor,
      ),
    );
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}
