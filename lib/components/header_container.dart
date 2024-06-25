import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://media1.popsugar-assets.com/files/thumbor/ixJC10IDXK_6RTEUQjjs7YFqC4I=/fit-in/3648x4560/filters:format_auto():extract_cover():upscale()/2020/09/23/953/n/1922507/e0f74b1ea4d60681_pexels-eberhard-grossgasteiger-2088142.jpg',
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Beta X',
              style: GoogleFonts.robotoSlab(
                textStyle: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              'Applications Testing',
              style: GoogleFonts.robotoSlab(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 3
                ),
              ),
            ),
            Text(
              'Builded by Nyonz',
              style: GoogleFonts.robotoSlab(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 3
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}