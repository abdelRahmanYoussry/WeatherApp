import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/HomeController.dart';
import '../model/FiveDaysData.dart';



class MyChart extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/4,
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SfCartesianChart(
          enableAxisAnimation: true,
          enableSideBySideSeriesPlacement: true,
          primaryXAxis: CategoryAxis(
            maximum: 1.0,
            minimum: 8,
            arrangeByIndex: true,
          ),
          series: <ChartSeries<FiveDaysData, String>>[
            LineSeries<FiveDaysData, String>(
              width: 2,
              dataSource: controller.fiveDaysData,
              xValueMapper: (FiveDaysData f, _) =>
              f.newDateTime!.split('-')[2],color: Colors.orangeAccent,enableTooltip: true,
              yValueMapper: (FiveDaysData f, _) =>
              f.temp,
            ),
          ],
        ),
      ),
    );
  }
}
