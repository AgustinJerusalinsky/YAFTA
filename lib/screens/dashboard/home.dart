import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/cells/balance_graph.dart';
import 'package:yafta/design_system/molecules/yafta_segmented_button.dart';
import 'package:yafta/services/movement_provider.dart';
import 'package:yafta/utils/remote_config.dart';

import '../../design_system/cells/balance_card.dart';
import '../../models/movement.dart';
import '../../models/segment.dart';

final List<Segment> segments = [
  Segment(label: "Semana", value: 0),
  Segment(label: "Mes", value: 1),
  Segment(label: "Total", value: 2),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedSegment = 0;

  void _onSelectionChanged(int idx, MovementProvider provider) {
    setState(() {
      _selectedSegment = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovementProvider>(
      builder: (context, movementProvider, _) {
        List<Movement> incomes = [];
        List<Movement> expenses = [];
        bool loadingIncomes = true;
        bool loadingExpenses = true;
        switch (_selectedSegment) {
          case 0:
            incomes = movementProvider.weekIncomes;
            expenses = movementProvider.weekExpenses;
            loadingIncomes = movementProvider.incomesWeekShouldFetch;
            loadingExpenses = movementProvider.expensesWeekShouldFetch;
            break;
          case 1:
            incomes = movementProvider.monthIncomes;
            expenses = movementProvider.monthExpenses;
            loadingIncomes = movementProvider.incomesMonthShouldFetch;
            loadingExpenses = movementProvider.expensesMonthShouldFetch;
            break;
          case 2:
            incomes = movementProvider.totalIncomes;
            expenses = movementProvider.totalExpenses;
            loadingIncomes = movementProvider.incomesTotalShouldFetch;
            loadingExpenses = movementProvider.expensesTotalShouldFetch;
            break;
        }

        final totalIncome = incomes.fold<double>(
            0, (previousValue, element) => previousValue + element.amount);

        final totalExpense = expenses.fold<double>(
            0, (previousValue, element) => previousValue + element.amount);

        final Map<String, double> expensesByCategory = {};
        final Map<String, double> incomesByCategory = {};

        for (var element in expenses) {
          if (expensesByCategory.containsKey(element.category.categoryId)) {
            expensesByCategory[element.category.categoryId!] =
                expensesByCategory[element.category.categoryId]! +
                    element.amount;
          } else {
            expensesByCategory[element.category.name] = element.amount;
          }
        }
        for (var element in incomes) {
          if (incomesByCategory.containsKey(element.category.name)) {
            incomesByCategory[element.category.name] =
                incomesByCategory[element.category.name]! + element.amount;
          } else {
            incomesByCategory[element.category.name] = element.amount;
          }
        }

        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            YaftaSegmentedButton(
              onSelectionChanged: (idx) =>
                  _onSelectionChanged(idx, movementProvider),
              segments: segments,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 26.0),
                children: [
                  BalanceCard(
                    total: (totalIncome - totalExpense).toStringAsFixed(2),
                    income: '\$ ${totalIncome.toStringAsFixed(2)}',
                    expenses: '\$ ${totalExpense.toStringAsFixed(2)}',
                    loadingExpenses: loadingExpenses,
                    loadingIncomes: loadingIncomes,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (RemoteConfigHandler.instance!.getBudgets() &&
                      (expensesByCategory.isNotEmpty &&
                          incomesByCategory.isNotEmpty))
                    Column(
                      children: [
                        Text(
                          "Categorias",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BalanceGraph(
                          expenseData: expensesByCategory,
                          incomeData: incomesByCategory,
                          incomeLoading: loadingIncomes,
                          expenseLoading: loadingExpenses,
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
