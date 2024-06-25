import 'package:beta_x/widgets/product_grid.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  ProductsView({super.key});
  ProductsController productControl = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductsView'),
        centerTitle: true,
      ),
      body: GestureDetector(
          onTap: () {
            //here
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // ListTile(
                  //   leading: Icon(Icons.ac_unit_sharp),
                  //   title: Text('KONTOL'),
                  //   subtitle: Text('TITIT'),
                  //   trailing: Icon(Icons.accessibility_outlined),
                  //   shape: RoundedRectangleBorder(
                  //     side: BorderSide(color: Colors.black, width: 1),
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  // ),
                  Obx(
                    () {
                      return Column(
                        children: [
                          for (var item in productControl.productModel)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                leading: Text(item.id.toString()),
                                title: Text(item.title),
                                subtitle: Text(
                                  item.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Icon(Icons.accessibility_outlined),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
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
