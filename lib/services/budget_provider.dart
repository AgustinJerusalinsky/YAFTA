import 'package:flutter/material.dart';
import 'package:yafta/models/budget.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/screens/budgets/budgets.dart';

import '../data/firestore_service.dart';

class BudgetProvider extends ChangeNotifier {
  final FirestoreService firestoreService = FirestoreService.instance;

  // add category
  Future<void> addCategory(
      String userId, String name, int amount, MovementType type) {
    Category category = Category(name: name, amount: amount, type: type);
    return firestoreService.addCategory(userId, category);
  }

  // get categories
  Future<List<Category>> getCategories(String userId) {
    return firestoreService.getCategories(userId);
  }

  // get budget
  Future<List<Budget>> getBudgets(String userId) async {
    List<Category> categories = await getCategories(userId);

    Map<String, Budget> budgets = {};

    categories.forEach((category) {
      budgets[category.categoryId!] = Budget(
        category: category,
        total: category.amount,
      );
    });

    List<Movement> movements = await firestoreService.getMovementsMTD(userId);

    movements.forEach((movement) {
      budgets[movement.category.categoryId!]!.amount += movement.amount;
    });

    return budgets.values.toList();
  }
}
