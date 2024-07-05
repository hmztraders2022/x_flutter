import 'package:beta_x/widgets/reusable_grid_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/manage_sapi_controller.dart';
import '../models/child_menu.dart';
import '../models/examp.sapi_model.dart';

class ManageSapiView extends GetView<ManageSapiController> {
  ManageSapiView({Key? key}) : super(key: key);

  final List<ExampleImageSapiModel> imageTopSapi = [
    ExampleImageSapiModel(
        image: 'https://st.depositphotos.com/1006472/53465/i/1600/depositphotos_534659156-stock-photo-limousin-cow-cattle-dairy-farm.jpg'),
    ExampleImageSapiModel(
        image:
            'https://lh4.googleusercontent.com/proxy/E9O5UHkPYOJnV34FVIITAW7MEkwW2TugSse6WkiAOiu_8WgXd0kKVuc3Kt7s252Yvzd1ODWj-VZdwYgaprzfaSFHX1zZJl_lbsRB9t5ZaCQkE8k'),
    ExampleImageSapiModel(image: 'https://i.pinimg.com/736x/0c/54/80/0c548097578c92adfc48d9c474dc8b5e.jpg'),
  ];

  final List<ChildMenuSapiModel> childMenu = [
    ChildMenuSapiModel(title: 'Manage Keuangan', isActive: false, nameRoute: ManageSapiView(), contentIcon: Icons.attach_money),
    ChildMenuSapiModel(title: 'Manage Keuangan', isActive: false, nameRoute: ManageSapiView(), contentIcon: Icons.attach_money),
    ChildMenuSapiModel(title: 'Manage Keuangan', isActive: false, nameRoute: ManageSapiView(), contentIcon: Icons.attach_money),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250.0,
                    viewportFraction: 1,
                    autoPlay: true,
                  ),
                  items: imageTopSapi.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Image.network(
                            i.image,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const SizedBox(
                                height: 30.0,
                                width: 30.0,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
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
                        );
                      },
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Selamat Datang',
                      style: GoogleFonts.roboto(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Di Manajemen Sapi AR Farm',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.white,
              height: 200,
              child: reusableGridItem(
                width: MediaQuery.of(context).size.width,
                count: childMenu.length,
                countPerRow: 4,
                childBuilder: (buildContext, i) {
                  return Text('okok');
                },
                leftRatio: 1,
                rightRatio: 1,
              ),
            ),
            Text(
              'ManageSapiView is working',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
