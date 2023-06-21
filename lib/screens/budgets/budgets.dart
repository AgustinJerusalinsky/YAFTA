import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/cells/budget_ring.dart';
import 'package:yafta/design_system/molecules/yafta_segmented_button.dart';
import 'package:yafta/models/budget.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/screens/dashboard/home.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:yafta/services/budget_provider.dart';

import '../../models/segment.dart';

final List<Segment> segments = [
  Segment(label: "Gastos", value: 0),
  Segment(label: "Ingresos", value: 1),
];

class BudgetsScreen extends StatefulWidget {
  @override
  State<BudgetsScreen> createState() => _BudgetsScreenState();
}

class _BudgetsScreenState extends State<BudgetsScreen> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1);
  int _currentPage = 0;
  void onPageChanged(int page) {
    setState(() {
      _pageController.animateToPage(page,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(builder: (context, provider, _) {
      final budgets = provider.budgets;
      if (provider.budgetsShouldFetch) {
        return const Center(child: CircularProgressIndicator());
      }
      return Column(
        children: [
          SizedBox(
            height: 20,
          ),
          YaftaSegmentedButton(
            onSelectionChanged: onPageChanged,
            segments: segments,
            currentIndex: _currentPage,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                controller: _pageController,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  MovementType currentType =
                      index == 0 ? MovementType.expense : MovementType.income;

                  final categoryBudgets = budgets
                      .where((budget) => budget.category.type == currentType)
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        index == 0 ? 'Gastos' : 'Ingresos',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Divider(),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: categoryBudgets.length + 1,
                          itemBuilder: (context, index) {
                            if (index == categoryBudgets.length) {
                              return const SizedBox(
                                height: 80,
                              );
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: BudgetRing(
                                key: Key(categoryBudgets[index]
                                    .category
                                    .categoryId!),
                                budget: categoryBudgets[index].total,
                                totalMovement: categoryBudgets[index].amount,
                                category: categoryBudgets[index].category,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      );
    });
  }
}
