import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/pie_chart.dart';

class BalanceGraph extends StatelessWidget {
  const BalanceGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Text("Resumen de gastos",
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(
              height: 30,
            ),
            YaftaPieChart(data: {
              "Supermercado": 1000,
              "Transporte": 1000,
              "Ocio": 1000,
            }),
          ],
        ),
      ),
    );
  }
}
