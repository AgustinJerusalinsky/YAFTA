import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/cells/budget_ring.dart';
import 'package:yafta/models/budget.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:yafta/services/budget_provider.dart';

class BudgetsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(builder: (context, provider, _) {
      final budgets = provider.budgets;
      if (provider.budgetsShouldFetch) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        itemCount: budgets.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: BudgetRing(
              key: Key(budgets[index].category.categoryId!),
              budget:
                  budgets[index].total.toDouble(), //TODO change this to double
              spent: budgets[index].amount.toDouble(),
              category: budgets[index].category.name,
            ),
          );
        },
      );
    });
  }
}
