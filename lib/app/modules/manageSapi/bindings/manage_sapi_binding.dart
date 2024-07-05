import 'package:get/get.dart';

import '../controllers/manage_sapi_controller.dart';

class ManageSapiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageSapiController>(
      () => ManageSapiController(),
    );
  }
}
