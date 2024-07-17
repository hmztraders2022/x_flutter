import 'package:beta_x/widgets/text_style_custom.dart';
import 'package:flutter/material.dart';

Widget cardCustomInfo({required String titleCard, required String subtitleCard}) {
  return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: textCustomStyle(
            text: titleCard,
            fontSize: 14,
            fontWeight: FontWeight.w300,
            textColor: Colors.white,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10),
          child: textCustomStyle(
            text: subtitleCard,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            textColor: Colors.blueGrey[900]!,
          ),
        ),
      ],
    ),
  );
}
