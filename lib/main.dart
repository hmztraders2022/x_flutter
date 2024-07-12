import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  Intl.defaultLocale = 'id_ID';
  await dotenv.load(fileName: ".env");

  initializeDateFormatting('id_ID', null).then((_) {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  );
  });
}
