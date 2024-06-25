import 'package:flutter/material.dart';

Widget productGridView(double width) {
  const int count = 16;
  const int itemsPerRow = 2;
  const double ratio = 1 / 1;
  const double horizontalPadding = 0;
  final double calcHeight = ((width / itemsPerRow) - (horizontalPadding)) * (count / itemsPerRow).ceil() * (1 / ratio);
  return Container(
    padding: const EdgeInsets.all(10),
    width: width,
    color: Colors.white,
    height: calcHeight,
    child: GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      itemCount: count,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        crossAxisCount: itemsPerRow,
        childAspectRatio: ratio,
      ),
      itemBuilder: (context, index) {
        return SizedBox(
          child: Card(
            clipBehavior: Clip.hardEdge,
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: Image.network("https://picsum.photos/200?${DateTime.now().millisecondsSinceEpoch.toString()}")),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      "Lorem Ipsum is a dummy text, lorem ipsum",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}