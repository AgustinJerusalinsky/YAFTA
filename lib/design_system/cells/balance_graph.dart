import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/pie_chart.dart';

class BalanceGraph extends StatelessWidget {
  const BalanceGraph(
      {Key? key, required this.incomeData, required this.expenseData})
      : super(key: key);

  final Map<String, double> incomeData;
  final Map<String, double> expenseData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 10,
        children: [
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Column(
                children: [
                  Text("Gastos",
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 20),
                  YaftaPieChart(
                    data: expenseData,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Column(
                children: [
                  Text("Ingresos",
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 20),
                  YaftaPieChart(
                    data: incomeData,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
