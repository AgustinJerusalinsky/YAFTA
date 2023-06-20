import 'package:flutter/material.dart';
import 'package:yafta/design_system/cells/categories_search.dart';
import 'package:yafta/design_system/cells/movement_row.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';

import '../../design_system/cells/movement_screen.dart';

// final List<Movement> incomeMovements = [
//   Movement(
//       userId: "id",
//       amount: 1000,
//       category: "Comida",
//       type: MovementType.income,
//       date: DateTime.now()),
//   Movement(
//       userId: "id",
//       amount: 1000,
//       category: "Comida",
//       type: MovementType.income,
//       date: DateTime.now()),
//   Movement(
//       userId: "id",
//       amount: 1000,
//       category: "Comida",
//       type: MovementType.income,
//       date: DateTime.now()),
//   Movement(
//       userId: "id",
//       amount: 1000,
//       category: "Comida",
//       type: MovementType.income,
//       date: DateTime.now()),
//   Movement(
//       userId: "id",
//       amount: 1000,
//       category: "Comida",
//       type: MovementType.income,
//       date: DateTime.now()),
//   Movement(
//       userId: "id",
//       amount: 1000,
//       category: "Comida",
//       type: MovementType.income,
//       date: DateTime.now()),
// ];

final List<Movement> incomeMovements = [];

class IncomesScreen extends StatelessWidget {
  const IncomesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovementScreen(
        movements: incomeMovements, type: MovementType.income);
  }
}
