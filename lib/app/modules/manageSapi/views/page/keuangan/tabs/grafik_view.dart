import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widget/chart_custom.dart';
import 'controller/grafik_pengeluaran_controller.dart';

class GraficTabsView extends GetView<GrafikPengeluaranController> {
  GraficTabsView({
    super.key,
  });

  final GrafikPengeluaranController grafikPengeluaranController = Get.put(GrafikPengeluaranController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            'Grafik Perkembangan Pengeluaran',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: 70,
            child: Divider(
              color: Colors.grey[400],
            ),
          ),
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
          const SizedBox(height: 15),
          Text(
            'Filter data',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Material(
              elevation: 1.0,
              type: MaterialType.transparency,
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: GetBuilder<GrafikPengeluaranController>(
                init: GrafikPengeluaranController(),
                builder: (_) {
                  return Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      buttonFilterGrafic(
                        nameButton: 'Semua Tahun',
                        onPres: () {
                          grafikPengeluaranController.getGraficByYear('all');
                        },
                      ),
                      buttonFilterGrafic(
                        nameButton: '2 Tahun',
                        onPres: () {
                          grafikPengeluaranController.getGraficByYear('2');
                        },
                      ),
                      buttonFilterGrafic(
                        nameButton: '4 Tahun',
                        onPres: () {
                          grafikPengeluaranController.getGraficByYear('4');
                        },
                      ),
                      buttonFilterGrafic(
                        nameButton: '6 Tahun',
                        onPres: () {
                          grafikPengeluaranController.getGraficByYear('6');
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buttonFilterGrafic({required String nameButton, required void Function()? onPres}) {
  return ElevatedButton(
    onPressed: onPres,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    child: Text(
      nameButton,
      style: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
