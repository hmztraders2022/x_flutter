import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget titleCustomAppbar({required String title}) {
  return Text(
    title,
    style: GoogleFonts.roboto(
      fontSize: 20,
      color: Colors.white,
    ),
  );
}
