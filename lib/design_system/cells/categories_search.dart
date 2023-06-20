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
  List<String> items = [];
  bool loading = true;

  Future<void> loadCategories(BuildContext ctx) async {
    String userId = ctx.read<AuthProvider>().user!.uid;
    List<Category> categories =
        await ctx.read<BudgetProvider>().getCategories(userId);
    setState(() {
      items = categories.map((e) => e.name).toList();
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      label: "Categorías",
      emptyLabel: "Mostrando todas las cetegorías",
      items: items,
      onSelectedItemsChange: widget.onSelectedItemsChange,
      loading: loading,
      loadData: loadCategories,
    );
  }
}
