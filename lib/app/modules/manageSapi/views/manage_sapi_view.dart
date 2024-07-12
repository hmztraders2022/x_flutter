import 'package:beta_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/manage_sapi_controller.dart';
import '../models/child_menu.dart';
import '../models/examp.sapi_model.dart';
import '../widget/card_small_menu.dart';
import '../widget/header_sapi.dart';
import '../widget/list_tile_info.dart';

class ManageSapiView extends GetView<ManageSapiController> {
  ManageSapiView({super.key});

  final ManageSapiController manageSapiController = Get.put(ManageSapiController());

  final List<ExampleImageSapiModel> imageTopSapi = [
    ExampleImageSapiModel(
        image: 'https://st.depositphotos.com/1006472/53465/i/1600/depositphotos_534659156-stock-photo-limousin-cow-cattle-dairy-farm.jpg'),
    ExampleImageSapiModel(
        image:
            'https://lh4.googleusercontent.com/proxy/E9O5UHkPYOJnV34FVIITAW7MEkwW2TugSse6WkiAOiu_8WgXd0kKVuc3Kt7s252Yvzd1ODWj-VZdwYgaprzfaSFHX1zZJl_lbsRB9t5ZaCQkE8k'),
    ExampleImageSapiModel(image: 'https://i.pinimg.com/736x/0c/54/80/0c548097578c92adfc48d9c474dc8b5e.jpg'),
  ];

  final List<ChildMenuSapiModel> childMenu = [
    ChildMenuSapiModel(title: 'Pengeluaran', isActive: false, nameRoute: Routes.pengeluaranKeuangan, contentIcon: Icons.analytics_outlined),
    ChildMenuSapiModel(title: 'Pemasukkan', isActive: false, nameRoute: Routes.pengeluaranKeuangan, contentIcon: Icons.trending_up),
  ];

  final List<ChildMenuSapiModel> childMenuFarm = [
    ChildMenuSapiModel(title: 'Pembelian', isActive: false, nameRoute: Routes.pengeluaranKeuangan, contentIcon: Icons.shopping_bag_outlined),
    ChildMenuSapiModel(
        title: 'Penjualan', isActive: false, nameRoute: Routes.pengeluaranKeuangan, contentIcon: Icons.shopping_cart_checkout_outlined),
    ChildMenuSapiModel(title: 'Kerugian', isActive: false, nameRoute: Routes.pengeluaranKeuangan, contentIcon: Icons.trending_down),
    ChildMenuSapiModel(title: 'Aset', isActive: false, nameRoute: Routes.pengeluaranKeuangan, contentIcon: Icons.inventory_2_outlined),
  ];

  final List<ChildMenuSapiModel> childMenuAdmin = [
    ChildMenuSapiModel(title: 'Info Baru', isActive: false, nameRoute: Routes.pengeluaranKeuangan, contentIcon: Icons.new_label_outlined),
    ChildMenuSapiModel(title: 'Akun Baru', isActive: false, nameRoute: Routes.pengeluaranKeuangan, contentIcon: Icons.person_add_alt_1_outlined),
    ChildMenuSapiModel(title: 'User List', isActive: false, nameRoute: Routes.pengeluaranKeuangan, contentIcon: Icons.person_2_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSapi(imageTopSapi: imageTopSapi),
            ListMenuSapi(
              childMenu: childMenu,
              title: 'Keuangan',
            ),
            const SizedBox(height: 10),
            ListMenuSapi(
              childMenu: childMenuFarm,
              title: 'Sapi',
            ),
            const SizedBox(height: 10),
            ListMenuSapi(
              childMenu: childMenuAdmin,
              title: 'Super Admin',
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('BACK SEMENTARA'),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              // height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.black,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Informasi',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 15),
                  GetBuilder(
                    init: ManageSapiController(),
                    initState: (_) {
                      manageSapiController.getListInfo();
                    },
                    builder: (_) {
                      return Column(
                        children: [
                          for (var item in manageSapiController.listInfo)
                            listTileInfoSapi(
                              contexts: context,
                              idCard: item.idC,
                              date: manageSapiController.changeDateToFormat(item.dateCreated.toString()),
                              subtitle: item.subtitle,
                              isActive: item.isActive,
                              isExpired: item.isExpired,
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const Text(
              'ManageSapiView is working',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class ListMenuSapi extends GetView {
  const ListMenuSapi({
    super.key,
    required this.childMenu,
    required this.title,
  });

  final List<ChildMenuSapiModel> childMenu;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: 70,
            child: Divider(
              color: Colors.grey[400],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var item in childMenu) cardMenuSapi(title: item.title, contentIcon: item.contentIcon, nameRoute: item.nameRoute),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
