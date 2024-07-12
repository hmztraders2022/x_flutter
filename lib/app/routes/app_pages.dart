import 'package:beta_x/app/modules/manageSapi/views/page/keuangan/pengeluaran_views.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mallproduct/bindings/mallproduct_binding.dart';
import '../modules/mallproduct/views/mallproduct_view.dart';
import '../modules/manageSapi/bindings/manage_sapi_binding.dart';
import '../modules/manageSapi/views/manage_sapi_view.dart';
import '../modules/products/bindings/detail_product_binding.dart';
import '../modules/products/bindings/product_by_categories_binding.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/views/detail_product_view.dart';
import '../modules/products/views/product_by_categories_view.dart';
import '../modules/products/views/products_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const initial = Routes.login;
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.products,
      page: () => ProductsView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.mallProduct,
      page: () => MallproductView(),
      binding: MallproductBinding(),
    ),
    GetPage(
      name: _Paths.productByCategories,
      page: () => ProductByCategoriesView(),
      binding: ProductByCategoriesBinding(),
    ),
    GetPage(
      name: _Paths.detailProduct,
      page: () => DetailProductView(),
      binding: DetailProductBinding(),
    ),
    GetPage(
      name: _Paths.manageSapi,
      page: () => ManageSapiView(),
      binding: ManageSapiBinding(),
    ),
    GetPage(
      name: _Paths.pengeluaranKeuangan,
      page: () => PengeluaranKeuangan(),
    ),
  ];
}
