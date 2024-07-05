import 'package:get/get.dart';

import '../controllers/mallproduct_controller.dart';

class MallproductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MallproductController>(
      () => MallproductController(),
    );
  }
}
