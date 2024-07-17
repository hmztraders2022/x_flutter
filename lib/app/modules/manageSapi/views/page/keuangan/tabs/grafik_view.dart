import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../widgets/btn_group_year_filter.dart';
import '../../../../../../../widgets/card_custom_info.dart';
import '../../../../../../../widgets/reusable_grid_item.dart';
import '../../../../../../../widgets/title_tabs_custom.dart';
import '../../../../widget/chart_custom.dart';
import 'controller/grafik_pengeluaran_controller.dart';

class GraficTabsView extends GetView<GrafikPengeluaranController> {
  GraficTabsView({
    super.key,
  });

  final GrafikPengeluaranController grafikPengeluaranController = Get.put(GrafikPengeluaranController());

  @override
  Widget build(BuildContext context) {
    List<Widget> btnYearFilter = [
      buttonFilter(
        nameButton: 'Semua Tahun',
        onPres: () {
          grafikPengeluaranController.getGraficByYear('all');
        },
      ),
      buttonFilter(
        nameButton: '2 Tahun',
        onPres: () {
          grafikPengeluaranController.getGraficByYear('2');
        },
      ),
      buttonFilter(
        nameButton: '4 Tahun',
        onPres: () {
          grafikPengeluaranController.getGraficByYear('4');
        },
      ),
      buttonFilter(
        nameButton: '6 Tahun',
        onPres: () {
          grafikPengeluaranController.getGraficByYear('6');
        },
      ),
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),
          btnGroupYearFilter(
            context: context,
            childListWidget: [
              GetBuilder<GrafikPengeluaranController>(
                init: GrafikPengeluaranController(),
                builder: (_) {
                  return Wrap(
                    direction: Axis.horizontal,
                    children: btnYearFilter,
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                cardCustomInfo(
                  titleCard: 'Total Modal Tersimpan',
                  subtitleCard: 'Rp. 600000',
                ),
                const SizedBox(height: 10),
                cardCustomInfo(
                  titleCard: 'Total Modal Telah Keluar',
                  subtitleCard: 'Rp. 500000',
                ),
                const SizedBox(height: 10),
                cardCustomInfo(
                  titleCard: 'Total Sisa Modal Tersimpan',
                  subtitleCard: 'Rp. 100000',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GetBuilder<GrafikPengeluaranController>(
            init: GrafikPengeluaranController(),
            initState: (_) {
              grafikPengeluaranController.getGrafikPengeluaran();
            },
            builder: (_) {
              if (grafikPengeluaranController.isListByYear.value) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: chartCustomExample(context: context, data: grafikPengeluaranController.graficListByYear),
                );
              }
              return Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: chartCustomExample(context: context, data: grafikPengeluaranController.graficList),
              );
            },
          ),
          
          const SizedBox(height: 10),
          reusableGridItem(
            width: MediaQuery.of(context).size.width,
            count: 4,
            countPerRow: 2,
            childBuilder: (buildContext, i) {
              return Padding(
                padding: const EdgeInsets.all(2),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [],
                  ),
                ),
              );
            },
            leftRatio: 1,
            rightRatio: 1,
          )
        ],
      ),
    );
  }
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
