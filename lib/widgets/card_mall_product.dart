import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CardMallProduct extends GetView {
  final String title;
  final String city;
  final int id;
  final String image;
  final double price;
  final double stars;
  final int sold;

  const CardMallProduct(
      {super.key,
      required this.id,
      required this.title,
      required this.image,
      required this.price,
      required this.city,
      required this.stars,
      required this.sold});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
                ),
                child: Image.network(
                  image,
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
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.comicNeue(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    id % 2 == 0
                        ? Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: const BoxDecoration(color: Colors.amber),
                                child: const Text('Gratis', style: TextStyle(fontSize: 12)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(border: Border.all(color: Colors.amber, width: 1)),
                                child: const Text(
                                  'Ongkir',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.amber, width: 1)),
                                child: const Text(
                                  'Bebas Pengembalian',
                                  style: TextStyle(color: Colors.amber, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 5),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Rp.',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: price.toString(),
                            style: GoogleFonts.comicNeue(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                          size: 20,
                        ),
                        const SizedBox(width: 2),
                        Text(stars.toString(), style: const TextStyle(fontSize: 14)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '|',
                            style: TextStyle(color: Colors.grey[100]),
                          ),
                        ),
                        Text('${sold.toString()} terjual', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_city,
                          color: Colors.grey,
                          size: 20,
                        ),
                        Text(city, style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
