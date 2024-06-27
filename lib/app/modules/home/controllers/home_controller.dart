import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  final RxBool isPopExit = false.obs;

  void changePopExit() {
    if (!isPopExit.value) {
      isPopExit.value = true;
    } else {
      isPopExit.value = false;
    }
  }
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

  void increment() => count.value++;
}
