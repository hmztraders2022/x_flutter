import 'package:get/get.dart';

import '../models/table_keuangan_model.dart';

class BerandaKeuanganController extends GetxController {
  final RxInt showPageSize = 10.obs;
  final RxBool sortColumnId = true.obs;
  final RxInt currentSortColumn = 0.obs;

  final RxList<TableKeuanganModelNew> listPengeluaran = <TableKeuanganModelNew>[].obs;

  void getDataKeuangan() {
    listPengeluaran.clear();
    var listDataKeuangan = [
      {'tanggal': '2012-09-01', 'title': 'Pembelian test', 'isActive': 1, 'id': 1},
      {'tanggal': '2013-01-06', 'title': 'Pembelian test', 'isActive': 1, 'id': 2},
      {'tanggal': '2014-02-02', 'title': 'Pembelian test', 'isActive': 1, 'id': 3},
      {'tanggal': '2015-03-03', 'title': 'Pembelian test', 'isActive': 1, 'id': 4},
      {'tanggal': '2016-04-04', 'title': 'Pembelian test', 'isActive': 1, 'id': 5},
      {'tanggal': '2017-05-05', 'title': 'Pembelian test', 'isActive': 1, 'id': 6},
      {'tanggal': '2018-06-06', 'title': 'Pembelian test', 'isActive': 1, 'id': 7},
      {'tanggal': '2019-07-07', 'title': 'Pembelian test', 'isActive': 1, 'id': 8},
      {'tanggal': '2020-08-08', 'title': 'Pembelian test', 'isActive': 1, 'id': 9},
      {'tanggal': '2021-09-09', 'title': 'Pembelian test', 'isActive': 1, 'id': 10},
      {'tanggal': '2022-10-10', 'title': 'Pembelian test', 'isActive': 1, 'id': 11},
      {'tanggal': '2023-11-11', 'title': 'Pembelian test', 'isActive': 1, 'id': 12},
      {'tanggal': '2024-11-12', 'title': 'Pembelian test', 'isActive': 1, 'id': 13},
    ];

    List<TableKeuanganModelNew> listKeuanganTemp = listDataKeuangan.map((item) {
      return TableKeuanganModelNew.fromJson(item);
    }).toList();

    List<dynamic> dynamicData = listKeuanganTemp.map((item) => item as dynamic).toList();

    for (var item in dynamicData) {
      listPengeluaran.add(item);
    }
    print(listPengeluaran);
    // update();
  }

  void getDataKeuanganByYear(String years) {
    print(years);
  }
}
