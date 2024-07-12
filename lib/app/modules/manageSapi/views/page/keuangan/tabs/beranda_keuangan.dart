import 'package:beta_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/table_keuangan.dart';
import 'controller/beranda_keuangan_controller.dart';

class BerandaKeuanganView extends GetView<BerandaKeuanganController> {
  BerandaKeuanganView({super.key});

  final BerandaKeuanganController berandaKeuanganController = Get.put(BerandaKeuanganController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Beranda',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              width: 70,
              child: Divider(
                color: Colors.grey[400],
              ),
            ),
            Row(
              children: [
                buttonBerandaKeuangan(
                  onPres: () {
                    Get.toNamed(Routes.pengeluaranKeuanganTambah);
                  },
                  name: 'Data Baru',
                  contentIcon: Icons.add,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      'Filter data by Year',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GetBuilder<BerandaKeuanganController>(
                            init: BerandaKeuanganController(),
                            builder: (_) {
                              return Wrap(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  buttonFilter(
                                    nameButton: 'Semua Tahun',
                                    onPres: () {
                                      berandaKeuanganController.getDataKeuanganByYear('all');
                                    },
                                  ),
                                  buttonFilter(
                                    nameButton: '2 Tahun',
                                    onPres: () {
                                      berandaKeuanganController.getDataKeuanganByYear('2');
                                    },
                                  ),
                                  buttonFilter(
                                    nameButton: '4 Tahun',
                                    onPres: () {
                                      berandaKeuanganController.getDataKeuanganByYear('4');
                                    },
                                  ),
                                  buttonFilter(
                                    nameButton: '6 Tahun',
                                    onPres: () {
                                      berandaKeuanganController.getDataKeuanganByYear('6');
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Total Semua Tahun Pengeluaran Uang',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Rp. 300.000',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'List Data Pengeluaran',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'Swipe/ scroll',
                    style: GoogleFonts.roboto(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  GetBuilder(
                    init: BerandaKeuanganController(),
                    initState: (_) {
                      berandaKeuanganController.getDataKeuangan();
                    },
                    builder: (_) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TableKeuanganView(
                          dataPengeluaran: berandaKeuanganController,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

Widget buttonBerandaKeuangan({required void Function()? onPres, required String name, required IconData contentIcon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: ElevatedButton(
      onPressed: onPres,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        backgroundColor: const Color(0xFFF6F5F5),
      ),
      child: Row(
        children: [
          Icon(
            contentIcon,
            size: 20,
            color: Colors.blueGrey[900],
          ),
          Text(
            name,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.blueGrey[900],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buttonFilter({required String nameButton, required void Function()? onPres}) {
  return ElevatedButton(
    onPressed: onPres,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      backgroundColor: const Color(0xFFF6F5F5),
    ),
    child: Text(
      nameButton,
      style: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.blueGrey[900],
      ),
    ),
  );
}
