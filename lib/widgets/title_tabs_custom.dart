import 'package:beta_x/widgets/text_style_custom.dart';
import 'package:flutter/material.dart';

Widget titleTabsCustom({required String title}) {
  return Column(
    children: [
      const SizedBox(height: 10),
      textCustomStyle(
        text: title,
        textColor: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      SizedBox(
        width: 70,
        child: Divider(
          color: Colors.grey[400],
        ),
      ),
    ],
  );
}
