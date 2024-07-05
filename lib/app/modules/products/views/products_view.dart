import 'package:beta_x/app/modules/products/views/product_by_categories_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  ProductsView({super.key});
  final ProductsController productControl = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Category'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[50],
      body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // GetBuilder<ProductsController>(
                  //   init: ProductsController(),
                  //   initState: (_) {
                  //     productControl.getProductsFake();
                  //   },
                  //   builder: (builder) {
                  //     if (productControl.isLoading.value) {
                  //       return const Padding(
                  //         padding: EdgeInsets.only(top: 30),
                  //         child: Center(child: CircularProgressIndicator()),
                  //       );
                  //     }
                  //     if (productControl.errorMessageProductList.isNotEmpty) {
                  //       return Padding(
                  //         padding: const EdgeInsets.only(top: 30),
                  //         child: Center(
                  //           child: Text(
                  //             productControl.errorMessageProductList.value,
                  //             style: const TextStyle(color: Colors.red),
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //     return Column(
                  //       children: [
                  //         for (var item in productControl.productModel)
                  //           Padding(
                  //             padding: const EdgeInsets.symmetric(vertical: 5),
                  //             child: ListTile(
                  //               leading: Text(item.id.toString()),
                  //               title: Text(item.title),
                  //               subtitle: Text(
                  //                 item.description,
                  //                 maxLines: 2,
                  //                 overflow: TextOverflow.ellipsis,
                  //               ),
                  //               trailing: const Icon(Icons.accessibility_outlined),
                  //               shape: RoundedRectangleBorder(
                  //                 side: const BorderSide(color: Colors.black, width: 1),
                  //                 borderRadius: BorderRadius.circular(5),
                  //               ),
                  //             ),
                  //           ),
                  //       ],
                  //     );
                  //   },
                  // ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            productControl.refreshProductCategories();
                          },
                          child: const Text('Refresh Categories'),
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<ProductsController>(
                    init: ProductsController(),
                    initState: (_) {
                      productControl.getProductCategories();
                    },
                    builder: (_) {
                      if (productControl.isLoadingProductCategories.value) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (productControl.errorMessageCategoriesProduct.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Center(
                            child: Text(
                              productControl.errorMessageProductList.value,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      }
                      if (productControl.categoriesProduct.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Center(child: Text('Data Kosong')),
                        );
                      }
                      return Column(
                        children: [
                          for (var item in productControl.categoriesProduct)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                dense: true,
                                tileColor: Colors.white,
                                leading: Container(
                                  width: 50,
                                  color: Colors.red,
                                  child: Image.network(
                                    'https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg',
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const CircularProgressIndicator(
                                        color: Colors.blue,
                                      );
                                    },
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                      return Image.network(
                                        'https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg',
                                        fit: BoxFit.cover,
                                        width: 200,
                                        height: 200,
                                      );
                                    },
                                  ),
                                ),
                                title: Text(
                                  item.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  item.url,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onTap: () {
                                  Get.to(
                                    () => ProductByCategoriesView(),
                                    arguments: {'slug': item.slug, 'name': item.name},
                                  );
                                },
                              ),
                            ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class AutocompleteBasicExample extends StatelessWidget {
  const AutocompleteBasicExample({super.key});

  static const List<String> _kOptions = <String>['aardvark', 'bobcat', 'chameleon', 'appel', 'asin', 'akbar'];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
      fieldViewBuilder:
          (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
        // Implement the text field UI
        return TextField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          decoration: const InputDecoration(
            labelText: 'Type Here',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 1),
            ),
          ),
          onChanged: (text) {
            // Update suggestions based on user input
            // Implement the logic to filter and refresh suggestions
          },
          onSubmitted: (text) {
            // Handle the submission of the selected suggestion
            // Implement the logic for the selection action
          },
        );
      },
    );
  }
}
