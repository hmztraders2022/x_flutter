import 'package:flutter/widgets.dart';

class ChildMenuSapiModel {
  late String title;
  late bool isActive;
  late Widget nameRoute;
  late IconData contentIcon;

  ChildMenuSapiModel({
    required this.title,
    required this.isActive,
    required this.nameRoute,
    required this.contentIcon,
  });
}
