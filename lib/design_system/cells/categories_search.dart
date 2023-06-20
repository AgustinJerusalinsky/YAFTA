import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/search_bar.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:yafta/services/budget_provider.dart';

import '../../models/category.dart';

class CategoriesSearchBar extends StatefulWidget {
  const CategoriesSearchBar({Key? key, required this.onSelectedItemsChange})
      : super(key: key);

  final Function(List<String>) onSelectedItemsChange;

  @override
  State<CategoriesSearchBar> createState() => _CategoriesSearchBarState();
}

class _CategoriesSearchBarState extends State<CategoriesSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(
      builder: (context, provider, _) {
        return SearchBar(
          label: "Categorías",
          emptyLabel: "Mostrando todas las cetegorías",
          items: provider.categories.map((e) => e.name).toList(),
          onSelectedItemsChange: widget.onSelectedItemsChange,
          loading: provider.categoriesShouldFetch,
        );
      },
    );
  }
}
