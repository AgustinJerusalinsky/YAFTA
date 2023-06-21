import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/pie_chart.dart';

class BalanceGraph extends StatelessWidget {
  const BalanceGraph(
      {Key? key,
      required this.incomeData,
      required this.expenseData,
      required this.incomeLoading,
      required this.expenseLoading})
      : super(key: key);

  final Map<String, double> incomeData;
  final bool incomeLoading;
  final Map<String, double> expenseData;
  final bool expenseLoading;

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
                  expenseLoading
                      ? SizedBox(
                          child: Center(child: CircularProgressIndicator()),
                          height: 215,
                          width: 200)
                      : YaftaPieChart(
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
                  incomeLoading
                      ? SizedBox(
                          child: Center(child: CircularProgressIndicator()),
                          height: 215,
                          width: 200)
                      : YaftaPieChart(
                          data: incomeData,
                          colorList: [
                            Color(0xFF74b9ff),
                            Color(0xFF00b894),
                            Color(0xFF55efc4),
                            Color(0xFFe17055),
                            Color(0xFFff7675),
                            Color(0xFFa29bfe),
                            Color(0xFFfd79a8),
                            Color(0xFFffeaa7),
                          ],
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
