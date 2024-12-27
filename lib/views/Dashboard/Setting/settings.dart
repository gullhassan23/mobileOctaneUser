import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_octane/views/Constrants/Colors.dart';
import 'package:mobile_octane/views/Constrants/Font.dart';
import 'package:mobile_octane/views/Dashboard/Setting/Change_password.dart';
import 'package:mobile_octane/views/Dashboard/Setting/Edit_profile.dart';
import 'package:mobile_octane/views/DeleteAccount/DeleteAccount.dart';
import 'package:mobile_octane/views/Notification.dart';
import 'package:mobile_octane/views/Registration_Screens/Connect_Your_Account.dart';
import 'package:mobile_octane/views/Registration_Screens/Sign_In.dart';
import 'package:mobile_octane/views/TERMS/FAQ.dart';
import 'package:mobile_octane/views/TERMS/PrivacyPolicy.dart';
import 'package:mobile_octane/views/TERMS/PurchaseHistory.dart';
import 'package:mobile_octane/views/TERMS/TermConditions.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../backend/auth.dart';
import '../../../global/refs.dart';
import '../../../services/services/user_services.dart';
import '../../DeleteAccount/OTPdeleteAccount.dart';
import '../../My_Vehicles/My_Vehicles.dart';
import 'dart:async';
import 'package:app_to_foreground/app_to_foreground.dart';

import 'editcard.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  UserServices _userServices = Get.find<UserServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Headline("Setting"),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h, bottom: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingsItem(
                  text: "Edit Profile",
                  iconPath: "assets/img_notification.png",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit_Profile()));
                  }),
              Divider(
                color: Colors.black12.withOpacity(0.1),
              ),
              SettingsItem(
                  text: "Vehicles",
                  iconPath: "assets/img_notification_3.png",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => My_Vehicle(
                                  fromsetting: true,
                                )));
                  }),
              Divider(
                color: Colors.black12.withOpacity(0.1),
              ),
              SettingsItem(
                  text: "Notification Setting ",
                  iconPath: "assets/img_notification_20x20.png",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()));
                  }),
              Divider(
                color: Colors.black12.withOpacity(0.1),
              ),
              SettingsItem(
                  text: "FAQs",
                  iconPath: "assets/img_image_331.png",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FAQ()));
                  }),
              Divider(
                color: Colors.black12.withOpacity(0.1),
              ),
              SettingsItem(
                  text: "Purchase History",
                  iconPath: "assets/img_image_331_20x20.png",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PurchaseHistory()));
                  }),
              if (_userServices.customer.google != true)
                Column(
                  children: [
                    Divider(
                      color: Colors.black12.withOpacity(0.1),
                    ),
                    SettingsItem(
                        text: "Change Password",
                        iconPath: "assets/img_notification_1.png",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Changepassword()));
                        }),
                  ],
                ),
              Divider(
                color: Colors.black12.withOpacity(0.1),
              ),
              SettingsItem(
                  text: "Change Payment Method ",
                  iconPath: "assets/img_notification_2.png",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit_Card(
                                  fromsetting: true,
                                )));
                  }),
              Divider(
                color: Colors.black12.withOpacity(0.1),
              ),
              SettingsItem(
                  text: "Privacy Policy",
                  iconPath: "assets/img_notification_3.png",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicy()));
                  }),
              Divider(
                color: Colors.black12.withOpacity(0.1),
              ),
              SettingsItem(
                  text: "Terms of Use",
                  iconPath: "assets/img_notification_4.png",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TermConditions()));
                  }),
              Divider(
                color: Colors.black12.withOpacity(0.1),
              ),
              SettingsItem(
                  text: "Logout",
                  iconPath: "assets/img_notification_5.png",
                  onTap: () async {
                    customersRef
                        .doc(_userServices.customer.id)
                        .update({"devicetoken": ""});
                    await logout(
                        google: Get.find<UserServices>().google,
                        facebook: Get.find<UserServices>().facebook);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Sign_In()),
                      (route) => false,
                    );
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => Sign_In()));
                  }),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 312.h,
                  margin: EdgeInsets.only(bottom: 1.h),
                  child: Text(
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
              SizedBox(
                height: 15.h,
              ),
              InkWell(
                onTap: () async {
                  if (_userServices.customer.google == true) {
                    showDeleteAccountDialog(context);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeleteAccount()));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.h),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/img_notification_6.png",
                        width: 22.h,
                        height: 22.w,
                      ),
                      SizedBox(width: 13.w),
                      Text(
                        'Delete Account',
                        style: GoogleFonts.nunito(
                          fontSize: 18.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onTap;

  SettingsItem({
    required this.text,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 24.0,
              height: 24.0,
            ),
            SizedBox(width: 16.0),
            Text(
              text,
              style: GoogleFonts.nunito(
                fontSize: 14.sp,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showDeleteAccountDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'Delete Account',
          style: GoogleFonts.nunito(
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Are you sure you want to delete your account?',
                style: GoogleFonts.nunito(
                  // color: Colors.green,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: GoogleFonts.nunito(
                color: Colors.green,
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'Delete',
              style: GoogleFonts.nunito(
                color: Colors.red,
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            onPressed: () {
              // Call the function to delete the account
              deleteAccountgoogle(context);

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Sign_In()),
                (route) => false,
              );
            },
          ),
        ],
      );
    },
  );
}

void deleteAccountgoogle(BuildContext context) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Delete the user document in Firestore

      await customersRef.doc(user.uid).delete();

      // Delete the user account in Firebase Authentication
      await user.delete();
      await logout(
        google: Get.find<UserServices>().google,
      );
      // If you reach here, the account deletion was successful
      print("Account deleted successfully");
    }
  } catch (e) {
    // Handle errors here
    print("Error deleting account: $e");
    // Show a SnackBar with the error message
  }
}

Future<void> _showNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',

    sound: RawResourceAndroidNotificationSound('airhorn'), // Add this line

    actions: <AndroidNotificationAction>[
      AndroidNotificationAction(
        'id_2',
        'Action 1',
        icon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        contextual: true,
      ),
      AndroidNotificationAction(
        'id_2',
        'Action 2',
        titleColor: Color.fromARGB(255, 255, 0, 0),
        icon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      ),
      AndroidNotificationAction(
        "3",
        'Action 3',
        icon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        showsUserInterface: true,

        // By default, Android plugin will dismiss the notification when the
        // user tapped on a action (this mimics the behavior on iOS).
        cancelNotification: false,
      ),
    ],
  );

  NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );
  await FlutterLocalNotificationsPlugin().show(
      12, 'plain title', 'plain body', notificationDetails,
      payload: 'item z');
}

// Future<void> _showNotification() async {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Define callback for notification button click
//   Future<void> _onNotificationClick(String payload) async {
//     if (payload == 'accept_action') {
//       print('Accept button clicked');
//       // Add your code for accept action here
//     } else if (payload == 'reject_action') {
//       print('Reject button clicked');
//       // Add your code for reject action here
//     }
//   }

//    AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'your_channel_id', // Replace with your own channel ID
//     'your_channel_name', // Replace with your own channel name
//      // Replace with your own channel description
//     importance: Importance.max,
//     priority: Priority.high,
//     color: Colors.blue, // Notification color
//     styleInformation: DefaultStyleInformation(true, true),
//     enableVibration: true,
//     vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]), // Vibration pattern
//     actions: [
//       AndroidNotificationAction(
//         'accept_action', // ID for the Accept button
//         'Accept', // Title for the Accept button
//         // icon: 'accept_icon', // Optional icon for the Accept button
//       ),
//       AndroidNotificationAction(
//         'reject_action', // ID for the Reject button
//         'Reject', // Title for the Reject button
//         // icon: 'reject_icon', // Optional icon for the Reject button
//       ),
//     ],
//     timeoutAfter: 10000, // Time in milliseconds (10 seconds),
//   );

//    NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);

//   // Set up the callback for notification button click
//   await flutterLocalNotificationsPlugin.initialize(
//     InitializationSettings(
//       android: AndroidInitializationSettings('app_icon'), // Replace with your app icon
//     ),
//     onSelectNotification: (String payload) => _onNotificationClick(payload),
//   );

//   await flutterLocalNotificationsPlugin.show(
//     0, // Notification ID
//     'Fuel Added', // Notification Title
//     'Payment Successfully Pay', // Notification Body
//     platformChannelSpecifics,
//     payload: 'notification_payload', // Pass payload for button click handling
//   );
// }


