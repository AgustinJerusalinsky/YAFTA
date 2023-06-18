enum AppRoutes {
  login,
  signup,
  home,
  incomes,
  expenses,
  budgets,
  profile,
  error
}

final shellRoutes = [
  AppRoutes.home,
  AppRoutes.incomes,
  AppRoutes.expenses,
  AppRoutes.budgets
];

extension AppRouteExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.login:
        return "/login";
      case AppRoutes.signup:
        return "/signup";
      case AppRoutes.home:
        return "/";
      case AppRoutes.incomes:
        return "/incomes";
      case AppRoutes.expenses:
        return "/expenses";
      case AppRoutes.budgets:
        return "/budgets";
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
      case AppRoutes.home:
        return "home";
      case AppRoutes.incomes:
        return "incomes";
      case AppRoutes.expenses:
        return "expenses";
      case AppRoutes.budgets:
        return "budgets";
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
