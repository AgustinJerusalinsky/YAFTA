import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:yafta/design_system/molecules/pie_chart.dart';
import 'package:yafta/design_system/molecules/yafta_card.dart';

class BudgetRing extends StatelessWidget {
  const BudgetRing(
      {Key? key,
      required this.budget,
      required this.spent,
      required this.category})
      : super(key: key);

  final double budget;
  final double spent;
  final String category;

  @override
  Widget build(BuildContext context) {
    final double percentage = spent / budget * 100;
    final overBudgetPercentage = percentage - 100;
    final moreThan100percertOverbudget = overBudgetPercentage > 100;
    final bool showOverBudget = overBudgetPercentage > 0;

    final List<Color> colorList;
    final Map<String, double> data;
    if (showOverBudget) {
      colorList = [
        Colors.red,
        Theme.of(context).colorScheme.primary,
      ];
      data = {
        "Error": overBudgetPercentage,
        "Restante":
            moreThan100percertOverbudget ? 0 : 100 - overBudgetPercentage,
      };
    } else {
      colorList = [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.surfaceVariant,
      ];
      data = {
        "Gastado": percentage,
        "Restante": 100 - percentage,
      };
    }

    return YaftaCard(
      title: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.surfaceVariant,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                category,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Spacer(),
            PopupMenuButton(
              surfaceTintColor: Theme.of(context).colorScheme.surface,
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text("Eliminar"),
                  ),
                ];
              },
              icon: const Icon(Icons.more_vert),
            )
          ],
        ),
      ),
      mainSection: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        child: Row(
          children: [
            Expanded(
              child: YaftaPieChart(
                chartType: ChartType.ring,
                chartRadius: 100,
                initialAngleInDegree: 270,
                showLegends: false,
                showChartValues: false,
                showChartValueBackground: false,
                colorList: colorList,
                data: data,
                noAnimation: true,
              ),
            ),
            SizedBox(width: 50),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Utilizado",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "${percentage.toStringAsFixed(0)}%",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: showOverBudget
                              ? Colors.red
                              : Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    thickness: 3,
                  ),
                  Text(
                      showOverBudget
                          ? "\$${spent - budget} sobre el presupuesto"
                          : "\$${budget - spent} restantes",
                      style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
