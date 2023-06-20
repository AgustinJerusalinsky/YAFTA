import 'package:flutter/material.dart';
import 'package:yafta/design_system/cells/budget_ring.dart';

final List<String> categories = [
  "Alquiler",
  "Sueldo",
  "Comida",
  "Transporte",
  "Servicios",
  "Ropa",
  "Salud",
  "Educación",
  "Entretenimiento",
  "Otros"
];

class BudgetsScreen extends StatelessWidget {
  const BudgetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: BudgetRing(
            key: Key(categories[index]),
            budget: 5000, // Replace with your budget value for the category
            spent: 2300, // Replace with your spent value for the category
            category: categories[index],
          ),
        );
      },
    );
  }
}
