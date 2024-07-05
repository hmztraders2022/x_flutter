import 'package:beta_x/app/modules/products/controllers/detail_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({super.key});

  final DetailProductController detailProductController = Get.put(DetailProductController());
  final getParameterId = Get.parameters['id'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder(
              init: DetailProductController(),
              initState: (_) {
                detailProductController.getDetailProduct(id: int.parse(getParameterId!));
              },
              builder: (_) {
                if (detailProductController.isLoadingDetailProd.value) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (detailProductController.errorMessageDetailProd.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text(
                        detailProductController.errorMessageDetailProd.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }
                // detailProductController.detailProduct
                return Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 400,
                          child: Image.network(
                            detailProductController.detailProduct.first.images[0],
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
                        Positioned(
                          right: 0,
                          top: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // print(Get.parameters['id']);
                                  // print(Get.currentRoute);
                                },
                                icon: const Icon(Icons.share),
                                color: Colors.amber[800],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 6,
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.amber, width: 1)),
                                child: const Text(
                                  'Bebas Pengembalian',
                                  style: TextStyle(color: Colors.amber, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Rp.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: detailProductController.detailProduct.first.price.toString(),
                                  style: GoogleFonts.comicNeue(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              children: [
                                WidgetSpan(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Colors.red,
                                    ),
                                    child: Text(
                                      'Stars+',
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const WidgetSpan(child: SizedBox(width: 5)),
                                TextSpan(
                                  text: detailProductController.detailProduct.first.title,
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: List.generate(5, (index) => buildStar(context: context, rating: 3.5, index: index)),
                                ),
                                Text('(${detailProductController.detailProduct.first.rating.toString()})')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Table(
                          border: TableBorder(
                            horizontalInside: BorderSide(color: Colors.grey.shade300),
                            verticalInside: BorderSide(color: Colors.grey.shade300),
                            right: BorderSide(color: Colors.grey.shade300),
                          ),
                          children: [
                            TableRow(
                              children: [
                                rowProd(data: 'Stock'),
                                rowProd(data: detailProductController.detailProduct.first.stock.toString()),
                              ],
                            ),
                            TableRow(
                              children: [
                                rowProd(data: 'Category'),
                                rowProd(data: detailProductController.detailProduct.first.category),
                              ],
                            ),
                            TableRow(
                              children: [
                                rowProd(data: 'Discount'),
                                rowProd(data: detailProductController.detailProduct.first.discountPercentage.toString()),
                              ],
                            ),
                            TableRow(
                              children: [
                                rowProd(data: 'Rating'),
                                rowProd(data: detailProductController.detailProduct.first.rating.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description:',
                            style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(height: 10),
                          Obx(() {
                            return Text(
                              maxLines: detailProductController.seeDetailDesc.isTrue ? 50 : 3,
                              overflow: TextOverflow.ellipsis,
                              detailProductController.detailProduct.first.description,
                              style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w300),
                            );
                          }),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              detailProductController.changeSetDetailDesc();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // Background color
                              foregroundColor: Colors.black, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4), // Border radius
                              ),
                              minimumSize: const Size(double.infinity, 50), // Lebar penuh dan tinggi 50
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Lihat selengkapnya',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_downward,
                                  size: 18,
                                  color: Colors.grey[500],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: 'Back',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.refresh),
            label: 'Refresh',
          ),
        ],
        currentIndex: detailProductController.selectedIndexBarBottom.value,
        selectedItemColor: Colors.red[50],
        backgroundColor: Colors.amber.shade900,
        unselectedItemColor: Colors.white,
        onTap: (i) {
          detailProductController.changeSelectedIndexBarBottom(i);
          if (i == 0) {
            Get.back();
          } else if (i == 1) {
            detailProductController.refreshDetailProduct(detailProductController.detailProduct.first.id);
          }
        },
      ),
    );
  }
}

Widget rowProd({required String data}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Text(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      data,
      style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w300),
    ),
  );
}

Widget buildStar({required BuildContext context, required double rating, required int index}) {
  Icon icon;

  if (index >= rating) {
    icon = const Icon(
      Icons.star_border,
      color: Colors.amber,
    );
  } else if (index > rating - 1 && index < rating) {
    icon = const Icon(
      Icons.star_half,
      color: Colors.amber,
    );
  } else {
    icon = const Icon(
      Icons.star,
      color: Colors.amber,
    );
  }
  return new InkResponse(
    child: icon,
  );
}
