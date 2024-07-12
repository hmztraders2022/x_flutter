import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

import '../controller/beranda_keuangan_controller.dart';
import '../models/table_keuangan_model.dart';

class TableKeuanganView extends GetView {
  const TableKeuanganView({super.key, required this.dataPengeluaran});
  final BerandaKeuanganController dataPengeluaran;

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextColumn = TextStyle(
      color: Colors.blueGrey[900],
    );

    return Obx(() {
      return PaginatedDataTable(
        headingRowColor: WidgetStateProperty.all(Colors.blueGrey[100]),
        columns: [
          DataColumn(
            label: Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Text('Id', style: styleTextColumn),
            ),
            onSort: (int columnIndex, bool ascending) {
              dataPengeluaran.currentSortColumn.value = columnIndex;
              if (dataPengeluaran.sortColumnId.value) {
                dataPengeluaran.listPengeluaran.sort((a, b) => b.id.compareTo(a.id));
              } else {
                dataPengeluaran.listPengeluaran.sort((a, b) => a.id.compareTo(b.id));
              }
              dataPengeluaran.sortColumnId.value = !dataPengeluaran.sortColumnId.value;
            },
          ),
          DataColumn(
            label: Text('Judul', style: styleTextColumn),
          ),
          DataColumn(
            label: Text('Tanggal', style: styleTextColumn),
          ),
          DataColumn(
            label: Text('Status', style: styleTextColumn),
          ),
          DataColumn(
            label: Text('Action', style: styleTextColumn),
          ),
        ],
        rowsPerPage: dataPengeluaran.showPageSize.value,
        sortAscending: dataPengeluaran.sortColumnId.value,
        sortColumnIndex: dataPengeluaran.currentSortColumn.value,
        source: _DataSource(
          data: !dataPengeluaran.isListByYear.value ? dataPengeluaran.listPengeluaran : dataPengeluaran.listPengeluaranByYear,
          context: context,
        ),
        availableRowsPerPage: const [10, 25, 50, 100],
        showEmptyRows: false,
      );
    });
  }
}

class _DataSource extends DataTableSource {
  final List<TableKeuanganModelNew> data;
  final BuildContext context;

  String changeDateToFormat(String dates) {
    DateTime tanggal = DateTime.parse(dates);
    String tanggalFormatted = intl.DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(tanggal);
    return tanggalFormatted;
  }

  _DataSource({required this.data, required this.context});

  Future<void> showSheetBTM(BuildContext context, TableKeuanganModelNew data) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text('Close'),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ),
              Text(
                data.title,
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              notesTitleInfoDetail(createdTime: changeDateToFormat(data.tanggal), author: 'Hamzah'),
              const SizedBox(height: 10),
              Text(
                'desc',
                textAlign: TextAlign.justify,
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
      color: WidgetStateProperty.all(Colors.white),
      cells: [
        DataCell(Text(item.id.toString())),
        DataCell(Text(item.title)),
        DataCell(Text(changeDateToFormat(item.tanggal))),
        DataCell(Text(item.isActive == 1 ? 'Aktif' : 'Non-Aktif')),
        DataCell(
          ElevatedButton(
            onPressed: () {
              showSheetBTM(context, item);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              backgroundColor: Colors.blue[600],
            ),
            child: Text(
              'Detail',
              style: GoogleFonts.roboto(fontSize: 13, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

Widget notesTitleInfoDetail({required String createdTime, required String author}) {
  return Row(
    children: [
      Icon(
        Icons.access_time,
        size: 16,
        color: Colors.grey[800]?.withOpacity(.6),
      ),
      const SizedBox(width: 5),
      Text(
        createdTime,
        style: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Colors.grey[800],
        ),
      ),
      const SizedBox(width: 7),
      Text(
        "|",
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: Colors.grey[800],
        ),
      ),
      const SizedBox(width: 7),
      Icon(
        Icons.person,
        size: 16,
        color: Colors.grey[800]?.withOpacity(.6),
      ),
      const SizedBox(width: 5),
      Text(
        author,
        style: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Colors.grey[800],
        ),
      ),
    ],
  );
}
