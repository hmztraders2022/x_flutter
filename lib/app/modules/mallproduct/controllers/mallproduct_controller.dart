import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/mallproduct_model.dart';

class MallproductController extends GetxController with WidgetsBindingObserver {
  final _connect = GetConnect();
  final cacheManager = DefaultCacheManager();
  final getStorage = GetStorage();

  final Duration cacheDuration = const Duration(minutes: 10); // Durasi cache
  final RxBool loadingGetMallProduct = false.obs;
  final RxList<MallProductModel> mallProductList = <MallProductModel>[].obs;
  final RxString errorMessageMallProductList = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
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
      final lastActiveStr = getStorage.read('lastActive') ?? '';
      final lastActive = lastActiveStr.isNotEmpty ? DateTime.parse(lastActiveStr) : DateTime.now().subtract(const Duration(minutes: 11));

      if (DateTime.now().difference(lastActive) > const Duration(minutes: 10)) {
        refreshPosts();
      } else {
        getMallProduct();
      }
    } else if (state == AppLifecycleState.paused) {
      getStorage.write('lastActive', DateTime.now().toIso8601String());
    }
  }

  Future<dynamic> getMallProduct() async {
    try {
      errorMessageMallProductList.value = '';
      mallProductList.clear();
      loadingGetMallProduct(true);
      FileInfo? cacheFileInfo = await cacheManager.getFileFromCache('mallproduct');
      if (cacheFileInfo != null) {
        final cacheMetadata = await cacheManager.getFileFromCache('mallproduct_metadata');
        if (cacheMetadata != null) {
          final lastUpdate = DateTime.parse(await cacheMetadata.file.readAsString());
          if (DateTime.now().difference(lastUpdate) < const Duration(minutes: 10)) {
            final cachedData = await cacheFileInfo.file.readAsString();
            final decodedData = jsonDecode(cachedData);
            for (var item in decodedData) {
              MallProductModel items = MallProductModel.fromJson(item);
              mallProductList.add(items);
            }
            loadingGetMallProduct(false);
            update();
            return;
          }
        }
      }
      // if (cacheFileInfo != null && DateTime.now().difference(cacheFileInfo.validTill) < cacheDuration) {
      //   final cachedData = await cacheFileInfo.file.readAsString();
      //   final decodedData = jsonDecode(cachedData);
      //   for (var item in decodedData) {
      //     MallProductModel items = MallProductModel.fromJson(item);
      //     mallProductList.add(items);
      //   }
      //   loadingGetMallProduct(false);
      //   update();
      //   return;
      // }

      final response = await _connect.get('https://api.escuelajs.co/api/v1/products?offset=0&limit=10');
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
            MallProductModel items = MallProductModel.fromJson(item);
            mallProductList.add(items);
          }

          try {
            String mallProductListJson = jsonEncode(
              mallProductList.map((product) => product.toJson()).toList(),
            );
            await cacheManager.putFile(
              'mallproduct',
              utf8.encode(mallProductListJson),
              maxAge: cacheDuration, // Durasi kadaluarsa cache
            );
            await cacheManager.putFile('mallproduct_metadata', utf8.encode(DateTime.now().toIso8601String()));
          } catch (e) {
            Get.snackbar(
              'Cache Error',
              'Gagal menyimpan cache',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
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
      errorMessageMallProductList.value = 'Error: $e';
    } finally {
      loadingGetMallProduct(false);
      update();
    }
  }

  void refreshPosts() async {
    loadingGetMallProduct(true);
    update();
    mallProductList.clear(); // Clear list to force re-fetch
    await cacheManager.removeFile('mallproduct'); // Clear cache
    await cacheManager.removeFile('mallproduct_metadata'); // Clear metadata cache
    await getMallProduct();
  }

  void increment() => count.value++;
}
