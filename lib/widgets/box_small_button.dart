import 'package:beta_x/app/modules/products/views/products_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxSmallButton extends StatelessWidget {
  const BoxSmallButton({
    super.key,
    required this.contentTitle,
    required this.contentIcons,
    required this.isActive,
    required this.nameRoute,
  });

  final String contentTitle;
  final IconData contentIcons;
  final bool isActive;
  final Widget nameRoute;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isActive) {
          Get.to(() => nameRoute);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You select this menu $contentTitle'),
              action: SnackBarAction(
                label: 'X',
                onPressed: () {},
              ),
            ),
          );
        }
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.deepPurple[50],
              border: isActive ? Border.all(color: Colors.green, width: 1) : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              contentIcons,
              size: 30,
              color: isActive ? Colors.green : Colors.black45,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            contentTitle,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
