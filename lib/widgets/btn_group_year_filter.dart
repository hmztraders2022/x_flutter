import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget btnGroupYearFilter({required BuildContext context, required List<Widget> childListWidget}) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            'Filter data by Year',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: childListWidget,
            ),
          ),
        ],
      ),
    ),
  );
}
