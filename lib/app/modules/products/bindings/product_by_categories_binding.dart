import 'package:get/get.dart';

import '../controllers/product_by_categories_controller.dart';

class ProductByCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductByCategoriesController>(
      () => ProductByCategoriesController(),
    );
  }
}
