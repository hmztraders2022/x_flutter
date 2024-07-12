import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../views/page/keuangan/tabs/models/grafik_model.dart';

@override
Widget chartCustomExample({required BuildContext context, required List<GrafikModel> data}) {
  late TooltipBehavior tooltipBehavior = TooltipBehavior(enable: true);

  DateTime getYearFromDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return dateTime;
  }

  return Scaffold(
    body: Center(
      child: SfCartesianChart(
        onTooltipRender: (TooltipArgs args) {
          int index = int.parse(args.pointIndex.toString());
          List<dynamic>? chartdata = args.dataPoints;
          args.header = DateFormat('d MMM yyyy').format(chartdata?[index]!.x);
          args.text = 'Sales: ${chartdata?[index].y}';
        },
        primaryXAxis: const DateTimeAxis(),
        tooltipBehavior: tooltipBehavior,
        series: <CartesianSeries>[
          // Renders line chart
          LineSeries<GrafikModel, DateTime>(
            dataSource: data,
            xValueMapper: (GrafikModel sales, _) {
              return DateTime.parse(sales.tanggal.toString());
            },
            yValueMapper: (GrafikModel sales, _) => sales.sales,
            enableTooltip: true,
            dataLabelSettings: const DataLabelSettings(isVisible: false),
          )
        ],
      ),
    ),
  );
}
