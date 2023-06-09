import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/search_bar.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/services/budget_provider.dart';

final filterOptions = [
  "Esta semana",
  "Este mes",
  "Total",
];

class CategoriesSearchBar extends StatefulWidget {
  const CategoriesSearchBar(
      {Key? key,
      required this.onSelectedItemsChange,
      required this.onFilterChange,
      required this.selectedFilter,
      required this.type})
      : super(key: key);

  final Function(List<String>) onSelectedItemsChange;
  final Function(String) onFilterChange;
  final String selectedFilter;
  final MovementType type;

  @override
  State<CategoriesSearchBar> createState() => _CategoriesSearchBarState();
}

class _CategoriesSearchBarState extends State<CategoriesSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(
      builder: (context, provider, _) {
        return Row(
          children: [
            Expanded(
              child: YaftaSearchBar(
                label: "Categorías",
                onFilterChange: widget.onFilterChange,
                selectedFilter: widget.selectedFilter,
                emptyLabel: "Mostrando todas las cetegorías",
                items: provider.categories
                    .where((element) => element.type == widget.type)
                    .map((e) => e.name)
                    .toList(),
                onSelectedItemsChange: widget.onSelectedItemsChange,
                loading: provider.categoriesShouldFetch,
                filterOptions: filterOptions,
              ),
            ),
          ],
        );
      },
    );
  }
}
