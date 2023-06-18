import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class YaftaPieChart extends StatelessWidget {
  const YaftaPieChart({Key? key, required this.data}) : super(key: key);

  final Map<String, double> data;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: data,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 25,
      chartRadius: MediaQuery.of(context).size.width / 2,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      legendOptions: LegendOptions(
        showLegendsInRow: true,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: Theme.of(context).textTheme.labelLarge!,
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValues: true,
        decimalPlaces: 2,
        chartValueStyle: Theme.of(context).textTheme.labelSmall!,
        chartValueBackgroundColor: Theme.of(context).colorScheme.surface,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
