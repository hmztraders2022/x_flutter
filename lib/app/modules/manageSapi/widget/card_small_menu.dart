import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cardMenuSapi({required String title, required IconData contentIcon, required String nameRoute}) {
  return InkWell(
    onTap: () {
      Get.toNamed(nameRoute);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFFEEEDEB),
        ),
        child: Column(
          children: [
            Icon(
              contentIcon,
              size: 20,
              color: const Color(0xFF151515),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: const Color(0xFF151515),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
