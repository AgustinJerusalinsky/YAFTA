import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pie_chart/src/utils.dart';
import 'package:yafta/utils/remote_config.dart';

const List<Color> defaultDarkColorList = [
  Color(0xFFe74c3c), // Dark Red
  Color(0xFF3498db), // Dark Blue
  Color(0xFF00b894), // Dark Green
  Color(0xFFf1c40f), // Dark Yellow
  Color(0xFF8e44ad), // Dark Purple
  Color(0xFFd63031), // Dark Pink
  Color(0xFFc0392b), // Dark Orange
  Color(0xFF00cec9), // Dark Cyan
];

class YaftaPieChart extends StatelessWidget {
  const YaftaPieChart(
      {Key? key,
      required this.data,
      this.chartType,
      this.showLegends,
      this.showChartValues,
      this.showChartValueBackground,
      this.centerText,
      this.centerTextStyle,
      this.colorList,
      this.initialAngleInDegree,
      this.chartRadius,
      this.noAnimation = false})
      : super(key: key);

  final Map<String, double> data;
  final ChartType? chartType;
  final bool? showLegends;
  final bool? showChartValues;
  final bool? showChartValueBackground;
  final String? centerText;
  final TextStyle? centerTextStyle;
  final List<Color>? colorList;
  final double? initialAngleInDegree;
  final double? chartRadius;
  final bool noAnimation;

  @override
  Widget build(BuildContext context) {
    final List<Color> defaultColors =
        RemoteConfigHandler.getTheme() == AppTheme.light
            ? defaultColorList
            : defaultDarkColorList;
    return PieChart(
      dataMap: data,
      animationDuration:
          noAnimation ? Duration(milliseconds: 0) : Duration(milliseconds: 800),
      chartLegendSpacing: 25,
      chartRadius: chartRadius ?? MediaQuery.of(context).size.width / 2,
      initialAngleInDegree: initialAngleInDegree ?? 0,
      chartType: chartType ?? ChartType.disc,
      ringStrokeWidth: 32,
      colorList: colorList ?? defaultColors,
      centerText: centerText,
      centerTextStyle: centerTextStyle,
      legendOptions: LegendOptions(
        showLegendsInRow: true,
        legendPosition: LegendPosition.bottom,
        showLegends: showLegends ?? (data[''] == null ? true : false),
        legendShape: BoxShape.circle,
        legendTextStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValues: showChartValues ?? (data[''] == null ? true : false),
        decimalPlaces: 2,
        chartValueStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
        showChartValueBackground: showChartValueBackground ?? true,
        chartValueBackgroundColor: Theme.of(context).colorScheme.surface,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
