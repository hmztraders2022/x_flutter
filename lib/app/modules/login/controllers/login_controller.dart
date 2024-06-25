import 'package:get/get.dart';

class LoginController extends GetxController {
  final count = 0.obs;
  Rx<bool> showPassword = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void changeShowPassword() {
    if (showPassword.value) {
      showPassword.value = false;
    } else {
      showPassword.value = true;
    }
  }

  void increment() => count.value++;
}
