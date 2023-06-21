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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                width: 1,
              ),
            ),
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Column(
                children: [
                  Text("Gastos",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant)),
                  const SizedBox(height: 20),
                  expenseLoading
                      ? const SizedBox(
                          height: 215,
                          width: 200,
                          child: Center(child: CircularProgressIndicator()))
                      : YaftaPieChart(
                          data: expenseData,
                        ),
                ],
              ),
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                width: 1,
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Column(
                children: [
                  Text("Ingresos",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant)),
                  const SizedBox(height: 20),
                  incomeLoading
                      ? const SizedBox(
                          height: 215,
                          width: 200,
                          child: Center(child: CircularProgressIndicator()))
                      : YaftaPieChart(
                          data: incomeData,
                          colorList: const [
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
