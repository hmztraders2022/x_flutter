import 'dart:convert';

import 'package:beta_x/app/modules/products/models/product.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductsController extends GetxController {
  final _connect = GetConnect();
  final GetStorage box = GetStorage();

  final count = 0.obs;
  final RxBool isLoading = false.obs;
  late RxList<ProductModel> productModel = <ProductModel>[].obs;

  var lastFetchTime =
      DateTime.now().subtract(Duration(days: 1)); // Menginisialisasi dengan waktu yang lama sehingga fetch pertama kali selalu dilakukan
  final Duration cacheDuration = Duration(minutes: 10); // Atur durasi cache sesuai kebutuhan

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<dynamic> getProductsFake() async {
    if (box.hasData('posts') && box.hasData('cacheTime')) {
      if (DateTime.now().difference(DateTime.parse(box.read('cacheTime'))) < cacheDuration) {
        isLoading(true);
        var decodedData = jsonDecode(box.read('posts'));
        for (var item in decodedData) {
          ProductModel items = ProductModel.fromJson(item);
          productModel.add(items);
        }
        isLoading(false);
        update();
        return;
      }
    }

    try {
      box.remove('posts');
      box.remove('cacheTime');
      isLoading(true);
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
            box.write('posts', encodedData);
            box.write('cacheTime', DateTime.now().toString());
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
      Get.snackbar(
        'Error',
        'Error: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
      update();
    }
  }

  // DIBUTUHKAN JIKA FETCH ULANG AKAN DILAKUKAN MENGGUNAKAN EVENT TRIGGER
  void refreshPosts() async {
    isLoading(true);
    update();
    productModel.clear(); // Kosongkan list agar data di-fetch ulang
    box.remove('posts'); // Clear cache
    box.remove('cacheTime'); // Clear cache time
    await getProductsFake();
  }

  void increment() => count.value++;
}
