import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:yafta/models/budget.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/screens/budgets/budgets.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:yafta/services/movement_provider.dart';

import '../data/firestore_service.dart';
import '../utils/remote_config.dart';

final log = Logger('BudgetProvider');

class BudgetProvider extends ChangeNotifier {
  final FirestoreService firestoreService = FirestoreService.instance;
  final AuthProvider authProvider;
  final MovementProvider movementProvider;

  List<Budget> _budgets = [];
  List<Category> _categories = [];

  bool _budgetDirty = true;
  bool _categoryDirty = true;

  BudgetProvider(this.authProvider, this.movementProvider) {
    movementProvider.addListener(() {
      if (movementProvider.incomesShouldFetch ||
          movementProvider.expensesShouldFetch) {
        budgetDirty = true;
      }
    });
  }

  bool get budgetsShouldFetch => _budgetDirty;

  bool get categoriesShouldFetch => _categoryDirty;

  List<Budget> get budgets {
    String userId = authProvider.user!.uid;

    if (_budgetDirty) {
      _buildBudgets(userId).then((value) {
        budgets = value;
        budgetDirty = false;
        return _budgets;
      });
    }
    return _budgets;
  }

  List<Category> get categories {
    String userId = authProvider.user!.uid;

    if (_categoryDirty) {
      _getFirestoreCategories(userId).then((value) {
        categories = value;
        categoryDirty = false;
        return _categories;
      });
    }
    return _categories;
  }

  set budgetDirty(bool value) {
    _budgetDirty = value;
    notifyListeners();
  }

  set categoryDirty(bool value) {
    _categoryDirty = value;
    notifyListeners();
  }

  set budgets(List<Budget> value) {
    _budgets = value;
    notifyListeners();
  }

  set categories(List<Category> value) {
    _categories = value;
    notifyListeners();
  }

  // add category
  Future<Category> addCategory(String name, double amount, MovementType type) {
    Category category = Category(name: name, amount: amount, type: type);
    String userId = authProvider.user!.uid;
    return firestoreService.addCategory(userId, category).then((value) {
      budgetDirty = true;
      categoryDirty = true;
      return value;
    });
  }

  Future<Category> getCategory(String categoryId) async {
    if (_categoryDirty) {
      _categories = await _getFirestoreCategories(authProvider.user!.uid);
      categoryDirty = false;
    }
    return _categories
        .firstWhere((category) => category.categoryId == categoryId);
  }

  Future<Category> getCategoryByNameAndType(
      String name, MovementType type) async {
    if (_categoryDirty) {
      _categories = await _getFirestoreCategories(authProvider.user!.uid);
      categoryDirty = false;
    }
    print(_categories.map((e) => e.name));
    return _categories.firstWhere(
        (category) => category.name == name && category.type == type);
  }

  // update category
  Future<void> updateCategory(String categoryId, String name, double amount) {
    return firestoreService
        .updateCategory(
      authProvider.user!.uid,
      categoryId,
      name,
      amount,
    )
        .then((value) {
      budgetDirty = true;
      categoryDirty = true;
      movementProvider.incomeDirty = true;
      movementProvider.expenseDirty = true;
      return value;
    });
  }

  //delete category
  Future<void> deleteCategory(String categoryId) {
    return firestoreService
        .deleteCategory(authProvider.user!.uid, categoryId)
        .then((value) {
      budgetDirty = true;
      categoryDirty = true;
      movementProvider.incomeDirty = true;
      movementProvider.expenseDirty = true;
      return value;
    });
  }

  Future<bool> categoryExists(String name, MovementType type) async {
    String userId = authProvider.user!.uid;

    final firestoreCategories = await _getFirestoreCategories(userId);

    return firestoreCategories
        .any((category) => category.name == name && category.type == type);
  }

  // get categories
  Future<List<Category>> _getFirestoreCategories(String userId) {
    return firestoreService.getCategories(userId);
  }

  // get budget
  Future<List<Budget>> _buildBudgets(String userId) async {
    Map<String, Budget> budgetsMap = {};

    List<Category> firestoreCategories =
        await firestoreService.getCategories(userId);

    firestoreCategories
        .where((element) => element.name != noCategoryName)
        .forEach((category) {
      budgetsMap[category.categoryId!] = Budget(
        category: category,
        total: category.amount,
      );
    });

    List<Movement> movements = await firestoreService.getMovementsMTD(userId);

    movements
        .where((element) => element.category.name != noCategoryName)
        .forEach((movement) {
      budgetsMap[movement.category.categoryId]!.amount += movement.amount;
    });

    return budgetsMap.values.toList();
  }
}
