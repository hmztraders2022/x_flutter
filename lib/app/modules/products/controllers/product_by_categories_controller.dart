import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/product_detail.model.dart';

class ProductByCategoriesController extends GetxController with WidgetsBindingObserver {
  final _connect = GetConnect();
  final GetStorage getStorage = GetStorage();

  final RxBool isLoadingProductByCategories = false.obs;
  final RxList<ProductDetailModel> productByCategories = <ProductDetailModel>[].obs;
  final RxString errorMessageProductByCategories = ''.obs;

  final RxString slugByCategories = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkResumeProductByCategories(slugByCategories.value);
    } else if (state == AppLifecycleState.paused) {
      getStorage.write('lastActiveProductByCategory', DateTime.now().toIso8601String());
    }
  }

  void checkResumeProductByCategories(String slug) {
    final lastActiveStr = getStorage.read('lastActiveProductByCategory') ?? '';
    final lastActive = lastActiveStr.isNotEmpty ? DateTime.parse(lastActiveStr) : DateTime.now().subtract(const Duration(minutes: 11));

    if (DateTime.now().difference(lastActive) > const Duration(minutes: 10)) {
      refreshProductCategories(slug);
    } else {
      getProductByCategories(slug: slug);
    }
  }

  Future<dynamic> getProductByCategories({required String slug}) async {
    try {
      slugByCategories.value = slug;
      isLoadingProductByCategories(true);
      errorMessageProductByCategories.value = '';
      productByCategories.clear();
      if (getStorage.hasData('productByCategories_$slug') && getStorage.hasData('productByCategoriesCacheTime_$slug')) {
        final lastActiveStr = getStorage.read('productByCategoriesCacheTime_$slug') ?? '';
        final lastActive = lastActiveStr.isNotEmpty ? DateTime.parse(lastActiveStr) : DateTime.now().subtract(const Duration(minutes: 11));
        if (DateTime.now().difference(lastActive) < const Duration(minutes: 10)) {
          var decodedData = jsonDecode(getStorage.read('productByCategories_$slug'));
          for (var item in decodedData) {
            ProductDetailModel items = ProductDetailModel.fromJson(item);
            productByCategories.add(items);
          }
          isLoadingProductByCategories(false);
          update();
          return;
        }
      }
      final response = await _connect.get('https://dummyjson.com/products/category/${slug}');
      if (response.status.hasError) {
      } else {
        if (response.body['products'].isNotEmpty) {
          List<Map<String, dynamic>> selectedItem = [];
          for (var item in response.body['products']) {
            selectedItem.add({
              'id': item['id'],
              'title': item['title'],
              'description': item['description'],
              'category': item['category'],
              'discountPercentage': item['discountPercentage'],
              'price': item['price'],
              'stock': item['stock'],
              'rating': item['rating'],
              'images': item['images']
            });
          }
          if (selectedItem.isNotEmpty) {
            for (var item in selectedItem) {
              ProductDetailModel items = ProductDetailModel.fromJson(item);
              productByCategories.add(items);
            }

            if (productByCategories.isNotEmpty) {
              final encodedData = jsonEncode(productByCategories.map((product) => product.toJson()).toList());
              getStorage.write('productByCategories_$slug', encodedData);
              getStorage.write('productByCategoriesCacheTime_$slug', DateTime.now().toString());
            }
          }
          update();
        } else {
          Get.snackbar(
            'Error',
            'Data Tidak Ditemukan',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      errorMessageProductByCategories.value = 'Error: $e';
      print(e);
    } finally {
      update();
      isLoadingProductByCategories(false);
    }
  }

  void refreshProductCategories(String slug) async {
    isLoadingProductByCategories(true);
    update();
    productByCategories.clear(); // Kosongkan list agar data di-fetch ulang
    getStorage.remove('productByCategories_$slug'); // Clear cache
    getStorage.remove('productByCategoriesCacheTime_$slug'); // Clear cache time
    await getProductByCategories(slug: slug);
  }
}
