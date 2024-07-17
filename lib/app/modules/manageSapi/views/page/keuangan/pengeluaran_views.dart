import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pengeluaran_controller.dart';
import 'tabs/beranda_keuangan.dart';
import 'tabs/grafik_view.dart';
import 'tabs/kalkulasi_pengeluaran.dart';

class PengeluaranKeuangan extends GetView<PengeluaranController> {
  PengeluaranKeuangan({super.key});

  List<Widget> tabHeaderList = [
    const Tab(
      icon: Icon(Icons.home_filled),
      iconMargin: EdgeInsets.only(bottom: 8),
      text: "Beranda",
    ),
    const Tab(
      icon: Icon(Icons.area_chart),
      iconMargin: EdgeInsets.only(bottom: 8),
      text: "Summary",
    ),
    const Tab(
      icon: Icon(Icons.calculate),
      iconMargin: EdgeInsets.only(bottom: 8),
      text: "Kalkulasi",
    )
  ];

  List<Widget> tabViewList = [
    BerandaKeuanganView(),
    GraficTabsView(),
    KalkulasiPengeluaranView(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabHeaderList.length,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            'Olah Pengeluaran',
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blueGrey[900],
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.grey[400],
            labelColor: Colors.white,
            tabs: tabHeaderList,
          ),
        ),
        backgroundColor: Colors.grey[50],
        body: TabBarView(
          children: tabViewList,
        ),
      ),
    );
  }
}
