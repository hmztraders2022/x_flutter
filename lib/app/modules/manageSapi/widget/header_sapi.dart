import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/manage_sapi_controller.dart';
import '../models/examp.sapi_model.dart';

class HeaderSapi extends GetView<ManageSapiController> {
  const HeaderSapi({
    super.key,
    required this.imageTopSapi,
  });

  final List<ExampleImageSapiModel> imageTopSapi;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 280.0,
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
          bottom: 50,
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
          bottom: 30,
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
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
