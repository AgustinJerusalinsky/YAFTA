import 'package:flutter/material.dart';
import 'package:yafta/data/firestore_service.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';

import 'auth_provider.dart';

class MovementProvider extends ChangeNotifier {
  // FirestoreService instance
  final FirestoreService _firestoreService = FirestoreService.instance;
  final AuthProvider _authProvider;

  List<Movement> _incomes = [];
  List<Movement> _expenses = [];

  bool _incomeDirty = true;
  bool _expenseDirty = true;

  MovementProvider(this._authProvider);

  bool get incomesShouldFetch => _incomeDirty;

  bool get expensesShouldFetch => _expenseDirty;

  List<Movement> get incomes {
    String userId = _authProvider.user!.uid;

    if (_incomeDirty) {
      _getFirestoreIncomes(userId).then((value) {
        incomes = value;
        incomeDirty = false;
      });
    }
    return _incomes;
  }

  List<Movement> get expenses {
    String userId = _authProvider.user!.uid;

    if (_expenseDirty) {
      _getFirestoreExpenses(userId).then((value) {
        expenses = value;
        expenseDirty = false;
      });
    }
    return _expenses;
  }

  set incomeDirty(bool value) {
    _incomeDirty = value;
    notifyListeners();
  }

  set expenseDirty(bool value) {
    _expenseDirty = value;
    notifyListeners();
  }

  set incomes(List<Movement> value) {
    _incomes = value;
    notifyListeners();
  }

  set expenses(List<Movement> value) {
    _expenses = value;
    notifyListeners();
  }

  // add movement
  Future<void> addMovement(String userId, int amount, Category category,
      String description, MovementType type, DateTime date) {
    //add date to movement
    Movement movement = Movement(
      amount: amount,
      description: description,
      category: category,
      type: type,
      date: date,
    );

    // add movement to firestore
    return _firestoreService.addMovement(userId, movement).then((value) {
      if (type == MovementType.income) {
        incomeDirty = true;
      } else {
        expenseDirty = true;
      }
      return value;
    });
  }

  // get incomes
  Future<List<Movement>> _getFirestoreIncomes(userId) {
    return _firestoreService.getMovements(userId, types: [MovementType.income]);
  }

  // get expenses
  Future<List<Movement>> _getFirestoreExpenses(userId) {
    return _firestoreService
        .getMovements(userId, types: [MovementType.expense]);
  }
}
