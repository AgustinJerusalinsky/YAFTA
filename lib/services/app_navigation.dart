import 'package:flutter/material.dart';
import 'package:yafta/utils/remote_config.dart';

class AppNavigation extends ChangeNotifier {
  int _currentIndex = 0;
  static final _navigationItems = [
    {
      "icon": Icons.home_outlined,
      "label": "Inicio",
      "route": "/",
      "fabLabel": "Agregar",
      "fabRoute": "/add"
    },
    {
      "icon": Icons.trending_up,
      "label": "Ingresos",
      "route": "/incomes",
      "fabLabel": "Ingreso",
      "fabRoute": "/add/incomes"
    },
    {
      "icon": Icons.trending_down,
      "label": "Gastos",
      "route": "/expenses",
      "fabLabel": "Gasto",
      "fabRoute": "/add/expenses"
    },
    if (RemoteConfigHandler.getBudgets())
      {
        "icon": Icons.savings_outlined,
        "label": "Presupuestos",
        "route": "/budgets",
        "fabLabel": "Presupuesto",
        "fabRoute": "/add/budgets"
      }
  ];
  static List<Map<String, dynamic>> get navigationItems => _navigationItems;
  get currentNavigationItem => _navigationItems[_currentIndex];
  String get currentRoute => _navigationItems[_currentIndex]["label"] as String;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  String get currentOptionRoute {
    return _navigationItems[_currentIndex]["route"] as String;
  }
}
