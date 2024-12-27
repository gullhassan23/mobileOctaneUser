// ignore_for_file: file_names

import 'package:get/get.dart' hide Trans;
import 'package:mobile_octane/Controller/auth_controller.dart';
import 'package:mobile_octane/Controller/user_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}