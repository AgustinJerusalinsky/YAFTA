import 'package:flutter/material.dart';
import 'package:yafta/design_system/cells/categories_search.dart';

class IncomesScreen extends StatelessWidget {
  const IncomesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [CategoriesSearchBar()],
    );
  }
}
