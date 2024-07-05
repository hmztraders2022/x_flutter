import 'dart:convert';

import 'package:beta_x/app/modules/products/models/categories_product.model.dart';
import 'package:beta_x/app/modules/products/models/product.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductsController extends GetxController with WidgetsBindingObserver {
  final _connect = GetConnect();
  final GetStorage getStorage = GetStorage();

  final count = 0.obs;
  final RxBool isLoading = false.obs;
  late RxList<ProductModel> productModel = <ProductModel>[].obs;
  final RxString errorMessageProductList = ''.obs;

  final RxBool isLoadingProductCategories = false.obs;
  final RxList<CategoriesProductModel> categoriesProduct = <CategoriesProductModel>[].obs;
  final RxString errorMessageCategoriesProduct = ''.obs;
  

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
      checkResumeProductFake();
      checkResumeProductCategories();
    } else if (state == AppLifecycleState.paused) {
      getStorage.write('lastActive', DateTime.now().toIso8601String());
      getStorage.write('lastActiveProductCategoriesList', DateTime.now().toIso8601String());
    }
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  void checkResumeProductFake() {
    final lastActiveStr = getStorage.read('lastActive') ?? '';
    final lastActive = lastActiveStr.isNotEmpty ? DateTime.parse(lastActiveStr) : DateTime.now().subtract(const Duration(minutes: 11));

    if (DateTime.now().difference(lastActive) > const Duration(minutes: 10)) {
      refreshProductList();
    } else {
      getProductsFake();
    }
  }

  Future<dynamic> getProductsFake() async {
    try {
      errorMessageProductList.value = '';
      productModel.clear();
      isLoading(true);
      if (getStorage.hasData('posts') && getStorage.hasData('cacheTime')) {
        var decodedData = jsonDecode(getStorage.read('posts'));
        for (var item in decodedData) {
          ProductModel items = ProductModel.fromJson(item);
          productModel.add(items);
        }
        isLoading(false);
        update();
        return;
      }
      getStorage.remove('posts');
      getStorage.remove('cacheTime');
      final response = await _connect.get('https://fakestoreapi.com/products?limit=10');
      if (response.status.hasError) {
        Get.snackbar(
          'Error',
          'Terjadi kesalahan: ${response.statusText}',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        if (response.body.isNotEmpty) {
          for (var item in response.body) {
            ProductModel items = ProductModel.fromJson(item);
            productModel.add(items);
          }

          if (productModel.isNotEmpty) {
            var encodedData = jsonEncode(productModel);
            getStorage.write('posts', encodedData);
            getStorage.write('cacheTime', DateTime.now().toString());
          }
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
      errorMessageProductList.value = 'Error: $e';
    } finally {
      isLoading(false);
      update();
    }
  }

  void refreshProductList() async {
    isLoading(true);
    update();
    productModel.clear(); // Kosongkan list agar data di-fetch ulang
    getStorage.remove('posts'); // Clear cache
    getStorage.remove('cacheTime'); // Clear cache time
    await getProductsFake();
  }
  // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  void checkResumeProductCategories() {
    final lastActiveStr = getStorage.read('lastActiveProductCategoriesList') ?? '';
    final lastActive = lastActiveStr.isNotEmpty ? DateTime.parse(lastActiveStr) : DateTime.now().subtract(const Duration(minutes: 11));

    if (DateTime.now().difference(lastActive) > const Duration(minutes: 10)) {
      refreshProductCategories();
    } else {
      getProductCategories();
    }
  }

  Future<dynamic> getProductCategories() async {
    try {
      categoriesProduct.clear();
      errorMessageCategoriesProduct.value = '';
      isLoadingProductCategories(true);
      if (getStorage.hasData('categoriesProduct') && getStorage.hasData('categoriesProductCacheTime')) {
        final lastActiveStr = getStorage.read('categoriesProductCacheTime') ?? '';
        final lastActive = lastActiveStr.isNotEmpty ? DateTime.parse(lastActiveStr) : DateTime.now().subtract(const Duration(minutes: 11));
        if (DateTime.now().difference(lastActive) < const Duration(minutes: 10)) {
          var decodedData = jsonDecode(getStorage.read('categoriesProduct'));
          for (var item in decodedData) {
            CategoriesProductModel items = CategoriesProductModel.fromJson(item);
            categoriesProduct.add(items);
          }
          isLoading(false);
          update();
          return;
        }
      }
      final response = await _connect.get('https://dummyjson.com/products/categories');
      if (response.status.hasError) {
        Get.snackbar(
          'Error',
          'Terjadi kesalahan: ${response.statusText}',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        if (response.body.isNotEmpty) {
          for (var item in response.body) {
            CategoriesProductModel items = CategoriesProductModel.fromJson(item);
            categoriesProduct.add(items);
          }
          if (categoriesProduct.isNotEmpty) {
            final encodedData = jsonEncode(categoriesProduct);
            getStorage.write('categoriesProduct', encodedData);
            getStorage.write('categoriesProductCacheTime', DateTime.now().toString());
          }
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
      errorMessageCategoriesProduct.value = 'Error: $e';
    } finally {
      update();
      isLoadingProductCategories(false);
    }
  }

  void refreshProductCategories() async {
    isLoadingProductCategories(true);
    update();
    categoriesProduct.clear(); // Kosongkan list agar data di-fetch ulang
    getStorage.remove('categoriesProduct'); // Clear cache
    getStorage.remove('categoriesProductCacheTime'); // Clear cache time
    await getProductCategories();
  }

  

  // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  void increment() => count.value++;
}
