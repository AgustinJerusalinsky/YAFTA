import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class YaftaPieChart extends StatelessWidget {
  const YaftaPieChart({Key? key, required this.data}) : super(key: key);

  final Map<String, double> data;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: data,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 10,
      chartRadius: MediaQuery.of(context).size.width / 2,
      baseChartColor: Theme.of(context).colorScheme.primary,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      legendOptions: LegendOptions(
        showLegendsInRow: true,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
