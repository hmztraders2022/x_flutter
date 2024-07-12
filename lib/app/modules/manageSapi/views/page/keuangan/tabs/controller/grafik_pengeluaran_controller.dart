import 'package:beta_x/app/modules/manageSapi/views/page/keuangan/tabs/models/grafik_model.dart';
import 'package:get/get.dart';

class GrafikPengeluaranController extends GetxController {
  final RxList<GrafikModel> graficList = <GrafikModel>[].obs;
  final RxList<GrafikModel> graficListByYear = <GrafikModel>[].obs;
  final RxBool isListByYear = false.obs;

  DateTime getYearFromDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return dateTime;
  }

  void getGrafikPengeluaran() {
    graficList.clear();
    isListByYear(false);
    var graficListOrder = [
      {'tanggal': '2012-09-01', 'sales': 10},
      {'tanggal': '2013-01-06', 'sales': 15},
      {'tanggal': '2014-02-02', 'sales': 20},
      {'tanggal': '2015-03-03', 'sales': 25},
      {'tanggal': '2016-04-04', 'sales': 16},
      {'tanggal': '2017-05-05', 'sales': 14},
      {'tanggal': '2018-06-06', 'sales': 18},
      {'tanggal': '2019-07-07', 'sales': 30},
      {'tanggal': '2020-08-08', 'sales': 32},
      {'tanggal': '2021-09-09', 'sales': 22},
      {'tanggal': '2022-10-10', 'sales': 40},
      {'tanggal': '2023-11-11', 'sales': 35},
      {'tanggal': '2024-11-12', 'sales': 5},
    ];

    List<GrafikModel> grafikListX = graficListOrder.map((item) {
      return GrafikModel.fromJson(item);
    }).toList();

    List<dynamic> dynamicData = grafikListX.map((item) => item as dynamic).toList();

    for (var item in dynamicData) {
      graficList.add(item);
    }
    update();
  }

  void getGraficByYear(String year) {
    isListByYear(true);
    graficListByYear.clear();
    var tempGrafic = [];
    for (var item in graficList) {
      Map<String, dynamic> tempX = item.toJson();
      DateTime inputDate = DateTime.parse(tempX['tanggal'].toString());
      DateTime currentDate = DateTime.now();
      if (year != 'all') {
        bool checked = checkIfMoreThanYears(inputDate, currentDate, int.parse(year));
        if (!checked) {
          tempGrafic.add(tempX);
        }
      } else {
        tempGrafic.add(tempX);
      }
    }
    for (var item in tempGrafic) {
      GrafikModel items = GrafikModel.fromJson(item);
      graficListByYear.add(items);
    }
    update();
  }

  bool checkIfMoreThanYears(DateTime date, DateTime currentDate, int years) {
    int yearDifference = currentDate.year - date.year;
    // Jika selisih tahun lebih dari years tahun, langsung kembalikan true
    if (yearDifference > years) {
      return true;
    }

    // Jika selisih tahun kurang dari years tahun, langsung kembalikan false
    if (yearDifference < years) {
      return false;
    }

    // Jika selisih tahun tepat years tahun, periksa bulan dan hari
    if (yearDifference == years) {
      if (currentDate.month > date.month) {
        return true;
      } else if (currentDate.month == date.month) {
        return currentDate.day >= date.day;
      }
    }

    return false;
  }
}
