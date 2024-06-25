import 'package:beta_x/app/modules/home/models/front_menu_model.dart';
import 'package:beta_x/app/modules/login/views/login_view.dart';
import 'package:beta_x/app/modules/products/views/products_view.dart';
import 'package:beta_x/components/header_container.dart';
import 'package:beta_x/widgets/box_small_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return const Text('Failed to load image');
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
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

Widget itemGrid(double width) {
  List<FrontMenuModel> frontMenuModel = [
    FrontMenuModel(title: 'Home', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.home_filled),
    FrontMenuModel(title: 'News', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.newspaper),
    FrontMenuModel(title: 'Chart', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.table_chart),
    FrontMenuModel(title: 'Money', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.money),
    FrontMenuModel(title: 'Data', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.data_exploration),
    FrontMenuModel(title: 'Camera', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.camera),
    FrontMenuModel(title: 'Settings', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.settings),
    FrontMenuModel(title: 'Profile', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.person),
    FrontMenuModel(title: 'Prducts', isActive: true, nameRoute: ProductsView(), contentIcon: Icons.category),
    FrontMenuModel(title: 'Log out', isActive: false, nameRoute: ProductsView(), contentIcon: Icons.logout),
    FrontMenuModel(title: 'Log in', isActive: true, nameRoute: LoginView(), contentIcon: Icons.login),
  ];

  int count = frontMenuModel.length;
  const int itemsPerRow = 4;
  const double ratio = 1 / 1;
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
