import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/button.dart';
import 'package:yafta/design_system/molecules/pie_chart.dart';
import 'package:yafta/design_system/molecules/yafta_card.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/utils/text.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/services/budget_provider.dart';

class BudgetRing extends StatelessWidget {
  const BudgetRing(
      {Key? key,
      required this.budget,
      required this.totalMovement,
      required this.category})
      : super(key: key);

  final double budget;
  final double totalMovement;
  final Category category;

  Future<void> deleteBudget(BuildContext context) async {
    final budgetProvider = context.read<BudgetProvider>();
    await budgetProvider.deleteCategory(category.categoryId!);
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Eliminar Presupuesto",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            content: Text(
              "Esta acción es irreversible y eliminará todos los movimientos asociados",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            actions: [
              TextButton(
                child: Text("Close",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.errorContainer)),
                  onPressed: () {
                    deleteBudget(context).then((value) {
                      //show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          backgroundColor:
                              Theme.of(context).colorScheme.errorContainer,
                          content: Text(
                            "Presupuesto eliminado",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onErrorContainer),
                          )));
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text("Eliminar",
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onErrorContainer)))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = totalMovement / budget * 100;
    final overBudgetPercentage = percentage - 100;
    final moreThan100percertOverbudget = overBudgetPercentage > 100;
    final bool showOverBudget = overBudgetPercentage > 0;

    final List<Color> colorList;
    final Map<String, double> data;
    final MovementType movementType = category.type;
    if (showOverBudget) {
      colorList = [
        (movementType == MovementType.expense
            ? Colors.red
            : Colors.green.shade300),
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
        Theme.of(context).colorScheme.surface,
      ];
      data = {
        "Gastado": percentage,
        "Restante": 100 - percentage,
      };
    }
    return YaftaCard(
      color: Theme.of(context).colorScheme.secondaryContainer,
      borderColor: Theme.of(context).colorScheme.onSecondaryContainer,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          color: Theme.of(context).colorScheme.secondaryContainer,
          border: Border.all(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
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
                category.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
            ),
            const Spacer(),
            PopupMenuButton(
              color: Theme.of(context).colorScheme.surfaceVariant,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text("Eliminar"),
                    onTap: () => showAlertDialog(context),
                  ),
                  PopupMenuItem(
                    child: const Text("Editar"),
                    onTap: () =>
                        context.push('/edit/budgets/${category.categoryId}'),
                  )
                ];
              },
              icon: Icon(Icons.more_vert,
                  color: Theme.of(context).colorScheme.onSecondaryContainer),
            )
          ],
        ),
      ),
      mainSection: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
            const SizedBox(width: 50),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movementType == MovementType.expense
                        ? "Utilizado"
                        : "Ingresado",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                  ),
                  Text(
                    "${percentage.toStringAsFixed(0)}%",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: showOverBudget
                            ? (movementType == MovementType.expense
                                ? Colors.red
                                : Colors.green.shade300)
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: getTextSizeBig(
                            "${percentage.toStringAsFixed(0)}%")),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    thickness: 3,
                  ),
                  Text(
                      showOverBudget
                          ? "\$${totalMovement - budget} sobre el presupuesto"
                          : "\$${budget - totalMovement} restantes",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
