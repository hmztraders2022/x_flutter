import 'package:flutter/widgets.dart';

class FrontMenuModel {
  late String title;
  late bool isActive;
  late Widget nameRoute;
  late IconData contentIcon;

  FrontMenuModel({
    required this.title,
    required this.isActive,
    required this.nameRoute,
    required this.contentIcon,
  });
}
