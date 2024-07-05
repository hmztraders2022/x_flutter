import 'package:beta_x/app/modules/products/views/detail_product_view.dart';
import 'package:beta_x/app/routes/app_pages.dart';
import 'package:beta_x/widgets/reusable_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/card_mall_product.dart';
import '../controllers/product_by_categories_controller.dart';

class ProductByCategoriesView extends GetView {
  ProductByCategoriesView({super.key});

  final ProductByCategoriesController productByCategoriesController = Get.put<ProductByCategoriesController>(ProductByCategoriesController());
  final Map<String, dynamic> arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories of ${arguments['name']}'),
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
                      productByCategoriesController.refreshProductCategories(arguments['slug']);
                    },
                    child: const Text('Refresh Product'),
                  ),
                ],
              ),
            ),
            GetBuilder<ProductByCategoriesController>(
              init: ProductByCategoriesController(),
              initState: (_) {
                productByCategoriesController.getProductByCategories(slug: arguments['slug']);
              },
              builder: (builder) {
                if (productByCategoriesController.isLoadingProductByCategories.value) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (productByCategoriesController.errorMessageProductByCategories.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text(
                        productByCategoriesController.errorMessageProductByCategories.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                if (productByCategoriesController.productByCategories.isNotEmpty) {
                  return reusableGridItem(
                    width: MediaQuery.of(context).size.width,
                    count: productByCategoriesController.productByCategories.length,
                    countPerRow: 2,
                    childBuilder: (buildContext, i) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.detailProduct, parameters: {'id': productByCategoriesController.productByCategories[i].id.toString()});
                        },
                        child: CardMallProduct(
                          id: productByCategoriesController.productByCategories[i].id,
                          title: productByCategoriesController.productByCategories[i].title,
                          image: productByCategoriesController.productByCategories[i].images[0],
                          price: productByCategoriesController.productByCategories[i].price,
                          sold: 100,
                          stars: productByCategoriesController.productByCategories[i].rating,
                          city: 'KOTA BANDUNG',
                        ),
                      );
                    },
                    leftRatio: 1,
                    rightRatio: 2,
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text('Data Kosong'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
