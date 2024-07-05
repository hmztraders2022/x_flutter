import 'package:flutter/material.dart';

Widget reusableGridItem(
    {required double width,
    required int count,
    required int countPerRow,
    required Widget Function(BuildContext, int) childBuilder,
    required double leftRatio,
    required double rightRatio}) {
  final int itemsPerRow = count < countPerRow ? count : countPerRow;
  double ratio = leftRatio / rightRatio;
  const double horizontalPadding = 0;
  const double verticalPadding = 2;
  final double calcHeight = ((width / itemsPerRow) - (horizontalPadding)) * (count / itemsPerRow).ceil() * (1 / ratio);
  return Container(
    padding: const EdgeInsets.all(2),
    width: width,
    color: Colors.transparent,
    height: calcHeight,
    child: GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      itemCount: count,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        crossAxisCount: itemsPerRow,
        childAspectRatio: ratio,
      ),
      itemBuilder: childBuilder,
    ),
  );
}
