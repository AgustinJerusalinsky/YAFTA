import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yafta/design_system/cells/categories_search.dart';
import 'package:yafta/design_system/cells/movement_row.dart';
import 'package:yafta/design_system/cells/movement_screen.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';

// final List<Movement> expenseMovements = [
//   Movement(
//       userId: "id",
//       amount: 1000,
//       category: "Comida",
//       type: MovementType.expense,
//       date: DateTime.now()),
//   Movement(
//       userId: "id",
//       amount: 1000,
//       category: "Comida",
//       type: MovementType.expense,
//       date: DateTime.now()),
//   Movement(
//       userId: "id",
//       amount: 1000,
//       category: "Comida",
//       type: MovementType.expense,
//       date: DateTime.now()),
//   Movement(
//       userId: "id",
//       amount: 1000,
//       category: "Comida",
//       type: MovementType.expense,
//       date: DateTime.now()),
//   Movement(
//       userId: "id",
//       amount: 1000,
//       category: "Comida",
//       type: MovementType.expense,
//       date: DateTime.now()),
//   Movement(
//       userId: "id",
//       amount: 1000,
//       category: "Comida",
//       type: MovementType.expense,
//       date: DateTime.now()),
// ];

final List<Movement> expenseMovements = [];

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovementScreen(
        movements: expenseMovements, type: MovementType.expense);
  }
}
