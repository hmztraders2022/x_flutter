import 'package:beta_x/app/modules/home/models/front_menu_model.dart';
import 'package:beta_x/app/modules/login/views/login_view.dart';
import 'package:beta_x/app/modules/mallproduct/views/mallproduct_view.dart';
import 'package:beta_x/app/modules/manageSapi/views/manage_sapi_view.dart';
import 'package:beta_x/app/modules/products/views/products_view.dart';
import 'package:beta_x/components/header_container.dart';
import 'package:beta_x/widgets/box_small_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  HomeController homeController = Get.put(HomeController());

  final bool isPopExit = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        canPop: homeController.isPopExit.value,
        onPopInvoked: (didPop) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tekan sekali lagi untuk keluar'),
            ),
          );
          homeController.changePopExit();
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            forceMaterialTransparency: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const HeaderContainer(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 800,
                  transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      itemGrid(MediaQuery.of(context).size.width),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: Image.network(
                    'https://blog.ippon.fr/content/images/2023/09/RGFzaGF0YXJfRGV2ZWxvcGVyX092ZXJJdF9jb2xvcl9QR19zaGFkb3c-.png',
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
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
                Text(
                  'Helloo..... friend',
                  style: GoogleFonts.comicNeue(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text(
                    'Kembali',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      );
    });
  }
}

Widget itemGrid(double width) {
  List<FrontMenuModel> frontMenuModel = [
    FrontMenuModel(title: 'Home', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.home_filled),
    FrontMenuModel(title: 'News', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.newspaper),
    FrontMenuModel(title: 'Chart', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.table_chart),
    FrontMenuModel(title: 'Money', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.money),
    FrontMenuModel(title: 'Mall Product', isActive: true, nameRoute: MallproductView(), contentIcon: Icons.production_quantity_limits),
    FrontMenuModel(title: 'Manage Sapi', isActive: true, nameRoute: ManageSapiView(), contentIcon: Icons.dataset),
    FrontMenuModel(title: 'Settings', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.settings),
    FrontMenuModel(title: 'Profile', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.person),
    FrontMenuModel(title: 'Product Category', isActive: true, nameRoute: ProductsView(), contentIcon: Icons.category),
    FrontMenuModel(title: 'Log out', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.logout),
    FrontMenuModel(title: 'Log in', isActive: true, nameRoute: LoginView(), contentIcon: Icons.login),
  ];

  int count = frontMenuModel.length;
  const int itemsPerRow = 4;
  const double ratio = 1 / 1.2;
  const double horizontalPadding = 0;
  final double calcHeight = ((width / itemsPerRow) - (horizontalPadding)) * (count / itemsPerRow).ceil() * (1 / ratio);
  return Container(
    padding: const EdgeInsets.all(10),
    width: width,
    color: Colors.white,
    height: calcHeight,
    child: GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      itemCount: count,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        crossAxisCount: itemsPerRow,
        childAspectRatio: ratio,
      ),
      itemBuilder: (context, index) {
        return BoxSmallButton(
          contentTitle: frontMenuModel[index].title,
          isActive: frontMenuModel[index].isActive,
          nameRoute: frontMenuModel[index].nameRoute,
          contentIcons: frontMenuModel[index].contentIcon,
        );
      },
    ),
  );
}
