import 'package:beta_x/app/modules/products/models/product.model.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final count = 0.obs;
  final isLoading = false.obs;

  late RxList<ProductModel> productModel = <ProductModel>[].obs;

  final _connect = GetConnect();

  @override
  Future<void> onInit() async {
    super.onInit();
    getProductsFake();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  getProductsFake() async {
    try {
      isLoading(true);
      final response = await _connect.get('https://fakestoreapi.com/products?limit=10');
      List<ProductModel> model = [];
      for (var item in response.body) {
        ProductModel test2 = ProductModel.fromJson(item);
        model.add(test2);
      }
      productModel.value = model;
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  void increment() => count.value++;
}
