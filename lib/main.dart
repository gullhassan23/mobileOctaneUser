import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:mobile_octane/views/Constrants/colors.dart';
import 'package:mobile_octane/views/Splash_Screen.dart';
import 'package:provider/provider.dart';

import 'AuthenticationService/AuthenticationService.dart';
import 'Providers/PlansProviders.dart';
import 'Widgets/shimmer.dart';
import 'dependency_inhection.dart';
import 'notification_services.dart';
import 'services/services/user_services.dart';
import 'system-util/display_mode_util.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future initServices() async {
  DependencyInjection.init();
  setHighRefreshRate();
  Stripe.publishableKey =
      "pk_test_51LYvOaG5oJVKdCdohaq2PoZRQfiMsxnFxdMXEKRRejxqi3J47f9ayTmrPHIWEelgADGiL9ZrysBM5TsMeUJg4LPS00urKX4NBZ";
  CustomEasyLoading.init();
  await Get.putAsync(() => UserServices().init());
  // Get.put<AddFuelController>(AddFuelController());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  notificationServices.requestNotificationPermission();
  notificationServices.forgroundMessage();
}

AuthenticationService authService = AuthenticationService();
NotificationServices notificationServices = NotificationServices();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    // webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );
  initServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<PlanProvider>(
                create: (context) => PlanProvider()),
          ],
          child: GetMaterialApp(
            builder: EasyLoading.init(),
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              backgroundColor: AppColors.backgroundColor,
              // colorScheme: ColorScheme.fromSeed(
              //     seedColor: Color.fromRGBO(235, 231, 254, 1)),
              useMaterial3: true,
            ),
            // home: RazorPay(),
            home: Splashscreen(),
            // home: payment()
          ),
        );
      },
    );
  }
}



