import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textCustomStyle({required Color textColor, required String text, required FontWeight fontWeight, required double fontSize}) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: textColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}
