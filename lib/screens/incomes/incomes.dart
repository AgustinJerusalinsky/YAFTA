import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/cells/categories_search.dart';
import 'package:yafta/design_system/cells/movement_row.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/services/movement_provider.dart';

import '../../design_system/cells/movement_screen.dart';

class IncomesScreen extends StatelessWidget {
  const IncomesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovementProvider>(builder: (context, provider, _) {
      final incomeMovements = provider.totalIncomes;
      return MovementScreen(
        movements: incomeMovements,
        type: MovementType.income,
        loading: provider.incomesTotalShouldFetch,
      );
    });
  }
}
