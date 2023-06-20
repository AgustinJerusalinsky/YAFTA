import 'package:flutter/material.dart';
import 'package:yafta/data/firestore_service.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/utils/analytics.dart';
import 'package:yafta/utils/remote_config.dart';

import 'auth_provider.dart';

class MovementProvider extends ChangeNotifier {
  // FirestoreService instance
  final FirestoreService _firestoreService = FirestoreService.instance;
  final AuthProvider _authProvider;

  List<Movement> _totalIncomes = [];
  List<Movement> _totalExpenses = [];
  List<Movement> _monthIncomes = [];
  List<Movement> _monthExpenses = [];
  List<Movement> _weekIncomes = [];
  List<Movement> _weekExpenses = [];

  bool _incomeTotalDirty = true;
  bool _expenseTotalDirty = true;
  bool _incomeMonthDirty = true;
  bool _expenseMonthDirty = true;
  bool _incomeWeekDirty = true;
  bool _expenseWeekDirty = true;

  MovementProvider(this._authProvider);

  bool get incomesTotalShouldFetch => _incomeTotalDirty;

  bool get expensesTotalShouldFetch => _expenseTotalDirty;

  bool get incomesMonthShouldFetch => _incomeMonthDirty;

  bool get expensesMonthShouldFetch => _expenseMonthDirty;

  bool get incomesWeekShouldFetch => _incomeWeekDirty;

  bool get expensesWeekShouldFetch => _expenseWeekDirty;

  bool get incomesShouldFetch =>
      _incomeTotalDirty || _incomeMonthDirty || _incomeWeekDirty;

  bool get expensesShouldFetch =>
      _expenseTotalDirty || _expenseMonthDirty || _expenseWeekDirty;

  List<Movement> get totalIncomes {
    String userId = _authProvider.user!.uid;

    if (_incomeTotalDirty) {
      _getFirestoreTotalIncomes(userId).then((value) {
        totalIncomes = value;
        incomeTotalDirty = false;
      });
    }
    return _totalIncomes;
  }

  List<Movement> get totalExpenses {
    String userId = _authProvider.user!.uid;

    if (_expenseTotalDirty) {
      _getFirestoreTotalExpenses(userId).then((value) {
        totalExpenses = value;
        expenseTotalDirty = false;
      });
    }
    return _totalExpenses;
  }

  List<Movement> get monthIncomes {
    String userId = _authProvider.user!.uid;

    if (_incomeMonthDirty) {
      _getFirestoreMonthIncomes(userId).then((value) {
        monthIncomes = value;
        incomeMonthDirty = false;
      });
    }
    return _monthIncomes;
  }

  List<Movement> get monthExpenses {
    String userId = _authProvider.user!.uid;

    if (_expenseMonthDirty) {
      _getFirestoreMonthExpenses(userId).then((value) {
        monthExpenses = value;
        expenseMonthDirty = false;
      });
    }
    return _monthExpenses;
  }

  List<Movement> get weekIncomes {
    String userId = _authProvider.user!.uid;

    if (_incomeWeekDirty) {
      _getFirestoreWeekIncomes(userId).then((value) {
        weekIncomes = value;
        incomeWeekDirty = false;
      });
    }
    return _weekIncomes;
  }

  List<Movement> get weekExpenses {
    String userId = _authProvider.user!.uid;

    if (_expenseWeekDirty) {
      _getFirestoreWeekExpenses(userId).then((value) {
        weekExpenses = value;
        expenseWeekDirty = false;
      });
    }
    return _weekExpenses;
  }

  set incomeTotalDirty(bool value) {
    _incomeTotalDirty = value;
    notifyListeners();
  }

  set expenseTotalDirty(bool value) {
    _expenseTotalDirty = value;
    notifyListeners();
  }

  set incomeMonthDirty(bool value) {
    _incomeMonthDirty = value;
    notifyListeners();
  }

  set expenseMonthDirty(bool value) {
    _expenseMonthDirty = value;
    notifyListeners();
  }

  set incomeWeekDirty(bool value) {
    _incomeWeekDirty = value;
    notifyListeners();
  }

  set expenseWeekDirty(bool value) {
    _expenseWeekDirty = value;
    notifyListeners();
  }

  set incomeDirty(bool value) {
    _incomeTotalDirty = value;
    _incomeMonthDirty = value;
    _incomeWeekDirty = value;
    notifyListeners();
  }

  set expenseDirty(bool value) {
    _expenseTotalDirty = value;
    _expenseMonthDirty = value;
    _expenseWeekDirty = value;
    notifyListeners();
  }

  set totalIncomes(List<Movement> value) {
    _totalIncomes = value;
    notifyListeners();
  }

  set totalExpenses(List<Movement> value) {
    _totalExpenses = value;
    notifyListeners();
  }

  set monthIncomes(List<Movement> value) {
    _monthIncomes = value;
    notifyListeners();
  }

  set monthExpenses(List<Movement> value) {
    _monthExpenses = value;
    notifyListeners();
  }

  set weekIncomes(List<Movement> value) {
    _weekIncomes = value;
    notifyListeners();
  }

  set weekExpenses(List<Movement> value) {
    _weekExpenses = value;
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

  // delete movement
  Future<void> deleteMovement(String userId, String movementId) {
    return _firestoreService.deleteMovement(userId, movementId).then((value) {
      incomeDirty = true;
      expenseDirty = true;
      return value;
    });
  }

  // get incomes
  Future<List<Movement>> _getFirestoreTotalIncomes(userId) {
    return _firestoreService.getMovements(userId, types: [MovementType.income]);
  }

  // get expenses
  Future<List<Movement>> _getFirestoreTotalExpenses(userId) {
    return _firestoreService
        .getMovements(userId, types: [MovementType.expense]);
  }

  Future<List<Movement>> _getFirestoreMonthIncomes(userId) {
    return _firestoreService
        .getMovementsMTD(userId, types: [MovementType.income]);
  }

  Future<List<Movement>> _getFirestoreMonthExpenses(userId) {
    return _firestoreService
        .getMovementsMTD(userId, types: [MovementType.expense]);
  }

  Future<List<Movement>> _getFirestoreWeekIncomes(userId) {
    return _firestoreService
        .getMovementsWeek(userId, types: [MovementType.income]);
  }

  Future<List<Movement>> _getFirestoreWeekExpenses(userId) {
    return _firestoreService
        .getMovementsWeek(userId, types: [MovementType.expense]);
  }
}
