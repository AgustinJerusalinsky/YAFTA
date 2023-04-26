import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AppNavigation extends ChangeNotifier {
  int _currentIndex = 0;
  static final _navigationItems = [
    {
      "icon": Icons.home_outlined,
      "label": "Inicio",
      "route": "/",
      "location": HomeLocation(),
    },
    {
      "icon": Icons.trending_up,
      "label": "Ingresos",
      "route": "/incomes",
      "location": IncomeLocation(),
    },
    {
      "icon": Icons.trending_down,
      "label": "Gastos",
      "route": "/expenses",
      "location": ExpensesLocation(),
    },
    {
      "icon": Icons.savings_outlined,
      "label": "Presupuestos",
      "route": "/budgets",
      "location": BudgetsLocation(),
    }
  ];
  List<Map<String, dynamic>> get navigationItems => _navigationItems;
  get currentNavigationItem => _navigationItems[_currentIndex];
  String get currentRoute => _navigationItems[_currentIndex]["label"] as String;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  BeamLocation get currentOptionLocation {
    return _navigationItems[_currentIndex]["location"] as BeamLocation;
  }

  String get currentOptionRoute {
    return _navigationItems[_currentIndex]["route"] as String;
  }
}
