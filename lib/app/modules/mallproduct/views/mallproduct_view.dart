import 'package:beta_x/widgets/card_mall_product.dart';
import 'package:beta_x/widgets/reusable_grid_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mallproduct_controller.dart';

class MallproductView extends GetView<MallproductController> {
  MallproductView({super.key});
  final MallproductController mallProductController = Get.put(MallproductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mall Product'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      mallProductController.refreshPosts();
                    },
                    child: const Text('Refresh Product'),
                  ),
                ],
              ),
            ),
            GetBuilder<MallproductController>(
              init: MallproductController(),
              initState: (_) {
                mallProductController.getMallProduct();
              },
              builder: (builder) {
                if (mallProductController.loadingGetMallProduct.value) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (mallProductController.errorMessageMallProductList.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text(
                        mallProductController.errorMessageMallProductList.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                if (mallProductController.mallProductList.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text('Text Kosong'),
                    ),
                  );
                }

                return reusableGridItem(
                  width: MediaQuery.of(context).size.width,
                  count: mallProductController.mallProductList.length,
                  countPerRow: 2,
                  leftRatio: 1,
                  rightRatio: 2,
                  childBuilder: (buildContext, i) {
                    return CardMallProduct(
                      id: mallProductController.mallProductList[i].id,
                      title: mallProductController.mallProductList[i].title,
                      image: mallProductController.mallProductList[i].images[0],
                      price: mallProductController.mallProductList[i].price,
                      sold: 100,
                      stars: 4.9,
                      city: 'KOTA BANDUNG',
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
