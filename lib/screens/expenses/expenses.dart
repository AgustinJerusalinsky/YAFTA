import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/cells/categories_search.dart';
import 'package:yafta/design_system/cells/movement_row.dart';
import 'package:yafta/design_system/cells/movement_screen.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/services/movement_provider.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovementProvider>(builder: (context, provider, _) {
      return MovementScreen(
        movements: provider.totalExpenses,
        type: MovementType.expense,
        loading: provider.expensesTotalShouldFetch,
      );
    });
  }
}
