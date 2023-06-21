import '../utils/remote_config.dart';

enum AppRoutes {
  login,
  signup,
  forgotPassword,
  home,
  incomes,
  addIncome,
  expenses,
  addExpense,
  budgets,
  addBudget,
  editBudget,
  profile,
  add,
  error
}

final shellRoutes = [
  AppRoutes.home,
  AppRoutes.incomes,
  AppRoutes.expenses,
  if (RemoteConfigHandler.getBudgets()) AppRoutes.budgets
];

extension AppRouteExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.login:
        return "/login";
      case AppRoutes.signup:
        return "/signup";
      case AppRoutes.forgotPassword:
        return "/forgotPassword";
      case AppRoutes.home:
        return "/";
      case AppRoutes.incomes:
        return "/incomes";
      case AppRoutes.add:
        return "/add";
      case AppRoutes.addIncome:
        return "/add/incomes";
      case AppRoutes.expenses:
        return "/expenses";
      case AppRoutes.addExpense:
        return "/add/expenses";
      case AppRoutes.budgets:
        return "/budgets";
      case AppRoutes.addBudget:
        return "/add/budgets";
      case AppRoutes.editBudget:
        return "/edit/budgets/:id";
      case AppRoutes.profile:
        return "/profile";
      default:
        return "/error";
    }
  }

  String get name {
    switch (this) {
      case AppRoutes.login:
        return "login";
      case AppRoutes.signup:
        return "signup";
      case AppRoutes.forgotPassword:
        return "forgotPassword";
      case AppRoutes.home:
        return "home";
      case AppRoutes.incomes:
        return "incomes";
      case AppRoutes.add:
        return "add";
      case AppRoutes.addIncome:
        return "addIncome";
      case AppRoutes.expenses:
        return "expenses";
      case AppRoutes.addExpense:
        return "addExpense";
      case AppRoutes.budgets:
        return "budgets";
      case AppRoutes.addBudget:
        return "addBudget";
      case AppRoutes.editBudget:
        return "editBudget";
      case AppRoutes.profile:
        return "profile";
      default:
        return "error";
    }
  }

  String get title {
    switch (this) {
      case AppRoutes.login:
        return "Iniciar sesión";
      case AppRoutes.signup:
        return "Registrarse";
      case AppRoutes.forgotPassword:
        return "Recuperar contraseña";
      case AppRoutes.home:
        return "Inicio";
      case AppRoutes.incomes:
        return "Ingresos";
      case AppRoutes.expenses:
        return "Gastos";
      case AppRoutes.budgets:
        return "Presupuestos";
      case AppRoutes.profile:
        return "Perfil";
      default:
        return "Error";
    }
  }
}
