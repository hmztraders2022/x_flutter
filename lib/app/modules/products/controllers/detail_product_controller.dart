import 'dart:convert';

import 'package:beta_x/app/modules/products/models/product_detail.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailProductController extends GetxController with WidgetsBindingObserver {
  final _connect = GetConnect();
  final GetStorage getStorage = GetStorage();

  final RxBool seeDetailDesc = false.obs;
  final RxString errorMessageDetailProd = ''.obs;
  late RxSet<DetailProductModel> detailProduct = <DetailProductModel>{}.obs;
  final RxBool isLoadingDetailProd = false.obs;
  final RxInt isIdDetail = 0.obs;

  final RxInt selectedIndexBarBottom = 0.obs;

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
      checkResumeDetailProduct(isIdDetail.value);
    } else if (state == AppLifecycleState.paused) {
      getStorage.write('lastActiveDetailProduct', DateTime.now().toIso8601String());
    }
  }

  void changeSetDetailDesc() {
    if (seeDetailDesc.isFalse) {
      seeDetailDesc(true);
    } else {
      seeDetailDesc(false);
    }
  }

  void changeSelectedIndexBarBottom(int index) {
    selectedIndexBarBottom.value = index;
  }

  void checkResumeDetailProduct(int id) {
    final lastActiveStr = getStorage.read('lastActiveProductByCategory') ?? '';
    final lastActive = lastActiveStr.isNotEmpty ? DateTime.parse(lastActiveStr) : DateTime.now().subtract(const Duration(minutes: 11));

    if (DateTime.now().difference(lastActive) > const Duration(minutes: 10)) {
      refreshDetailProduct(id);
    } else {
      getDetailProduct(id: id);
    }
  }

  Future<dynamic> getDetailProduct({required int id}) async {
    try {
      isLoadingDetailProd(true);
      isIdDetail.value = id;
      detailProduct.clear();
      errorMessageDetailProd.value = '';
      if (getStorage.hasData('detailProduct_$id') && getStorage.hasData('detailProductCacheTime_$id')) {
        final lastActiveStr = getStorage.read('detailProductCacheTime_$id') ?? '';
        final lastActive = lastActiveStr.isNotEmpty ? DateTime.parse(lastActiveStr) : DateTime.now().subtract(const Duration(minutes: 11));
        if (DateTime.now().difference(lastActive) < const Duration(minutes: 10)) {
          var decodedData = jsonDecode(getStorage.read('detailProduct_$id'));
          DetailProductModel convertFJ = DetailProductModel.fromJson(decodedData);
          detailProduct.add(convertFJ);
          isLoadingDetailProd(false);
          update();
          return;
        }
      }
      final response = await _connect.get('https://dummyjson.com/products/$id');
      if (response.hasError) {
      } else {
        DetailProductModel selectedDetail = DetailProductModel(
          id: response.body['id'],
          title: response.body['title'],
          description: response.body['description'],
          category: response.body['category'],
          price: response.body['price'],
          discountPercentage: response.body['discountPercentage'],
          stock: response.body['stock'],
          rating: response.body['rating'],
          images: response.body['images'],
        );
        detailProduct.add(selectedDetail);
        final encodedData = jsonEncode(detailProduct.first.toJson());
        getStorage.write('detailProduct_$id', encodedData);
        getStorage.write('detailProductCacheTime_$id', DateTime.now().toString());
      }
    } catch (e) {
      print(e);
    } finally {
      update();
      isLoadingDetailProd(false);
    }
  }

  void refreshDetailProduct(int id) async {
    isLoadingDetailProd(true);
    update();
    detailProduct.clear(); // Kosongkan list agar data di-fetch ulang
    getStorage.remove('detailProduct_$id'); // Clear cache
    getStorage.remove('detailProductCacheTime_$id'); // Clear cache time
    await getDetailProduct(id: id);
  }
}
