import 'package:get/get.dart';
 

import '../../Controller/user_controller.dart';
import '../../Model/customer_model.dart';

class UserServices extends GetxService {
  final UserController controller = Get.put(UserController());

  Future<UserServices> init() async {
    Get.put(UserServices());
    await controller.checkUserLogin();
    return this;
  }

  bool get auth => controller.login.value;

  CustomerModel get customer => controller.user.value;

  String get userid => customer.id ?? '';

  bool get apple => customer.apple ?? false;
  bool get google => customer.google ?? false;
  bool get facebook => customer.facebook ?? false;


  bool get isSocial => apple || google;

  updatePassword(String password) async =>
      await controller.updatePassword(password);

  updateProfile({
    required String name,
    required String email,
    required String image,
  }) async =>
      await controller.updateProfile(
        name: name,
        email: email,
        image: image,
      );
}
