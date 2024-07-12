import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pengeluaran_controller.dart';
import 'tabs/beranda_keuangan.dart';
import 'tabs/grafik_view.dart';

class PengeluaranKeuangan extends GetView<PengeluaranController> {
  const PengeluaranKeuangan({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
            unselectedLabelColor: Colors.white,
            labelColor: Colors.grey[400],
            tabs: const [
              Tab(
                icon: Icon(Icons.home_filled),
                iconMargin: EdgeInsets.only(bottom: 8),
                text: "Beranda",
              ),
              Tab(
                icon: Icon(Icons.area_chart),
                iconMargin: EdgeInsets.only(bottom: 8),
                text: "Grafik",
              ),
              Tab(
                icon: Icon(Icons.settings),
                iconMargin: EdgeInsets.only(bottom: 8),
                text: "Settings",
              )
            ],
          ),
        ),
        backgroundColor: Colors.grey[50],
        body: TabBarView(
          children: [
            BerandaKeuanganView(),
            GraficTabsView(),
            Center(
              child: Text("Settings"),
            ),
          ],
        ),
      ),
    );
  }
}
