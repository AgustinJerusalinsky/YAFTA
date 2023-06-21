import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yafta/design_system/molecules/main_layout.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/routing/router_utils.dart';
import 'package:yafta/screens/add.dart';
import 'package:yafta/screens/auth/forgot_password.dart';
import 'package:yafta/screens/auth/login.dart';
import 'package:yafta/screens/auth/signup.dart';
import 'package:yafta/screens/budgets/add_budget.dart';
import 'package:yafta/screens/budgets/edit_budget.dart';
import 'package:yafta/screens/dashboard/home.dart';
import 'package:yafta/screens/expenses/expenses.dart';
import 'package:yafta/screens/add_movement.dart';
import 'package:yafta/screens/profile/profile.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:yafta/utils/remote_config.dart';

import '../screens/budgets/budgets.dart';
import '../screens/error_screen.dart';
import '../screens/incomes/incomes.dart';

final GlobalKey<NavigatorState> _rootNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter {
  late final AuthProvider authProvider;
  GoRouter get router => _router;

  AppRouter(this.authProvider);

  late final _router = GoRouter(
      navigatorKey: _rootNavigator,
      initialLocation: "/",
      refreshListenable: authProvider,
      redirect: (BuildContext context, GoRouterState state) {
        final isLoggedIn = authProvider.user != null;
        final isGoingToLogin = state.location == AppRoutes.login.path;
        final isGoingToSignUp = state.location == AppRoutes.signup.path;
        final isResetingPassword =
            state.location == AppRoutes.forgotPassword.path;
        if (!isLoggedIn &&
            !isGoingToLogin &&
            !isGoingToSignUp &&
            !isResetingPassword) {
          return AppRoutes.login.path;
        } else {
          return null;
        }
      },
      routes: [
        GoRoute(
            path: AppRoutes.login.path,
            name: AppRoutes.login.name,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: LoginScreen())),
        GoRoute(
            path: AppRoutes.signup.path,
            name: AppRoutes.signup.name,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SignupScreen())),
        GoRoute(
            path: AppRoutes.forgotPassword.path,
            name: AppRoutes.forgotPassword.name,
            pageBuilder: (context, state) => CustomTransitionPage(
                  child: const ForgotPasswordScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          SlideTransition(
                              position: animation.drive(
                                Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ),
                              ),
                              child: child),
                )),
        GoRoute(
            parentNavigatorKey: _rootNavigator,
            path: AppRoutes.profile.path,
            name: AppRoutes.profile.name,
            pageBuilder: (context, state) => CustomTransitionPage(
                  child: const ProfileScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          SlideTransition(
                              position: animation.drive(
                                Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ),
                              ),
                              child: child),
                )),
        if (RemoteConfigHandler.instance!.getBudgets())
          GoRoute(
              parentNavigatorKey: _rootNavigator,
              path: AppRoutes.addBudget.path,
              name: AppRoutes.addBudget.name,
              pageBuilder: (context, state) => CustomTransitionPage(
                    child: const AddBudgetScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            SlideTransition(
                                position: animation.drive(
                                  Tween<Offset>(
                                    begin: const Offset(1, 0),
                                    end: Offset.zero,
                                  ),
                                ),
                                child: child),
                  )),
        GoRoute(
            parentNavigatorKey: _rootNavigator,
            path: AppRoutes.addIncome.path,
            name: AppRoutes.addIncome.name,
            pageBuilder: (context, state) {
              final amount = state.queryParameters['amount'];
              final description = state.queryParameters['description'];
              return CustomTransitionPage(
                child: AddMovementScreen(
                  type: MovementType.income,
                  amount: amount,
                  description: description,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ),
                            ),
                            child: child),
              );
            }),
        GoRoute(
            parentNavigatorKey: _rootNavigator,
            path: AppRoutes.addExpense.path,
            name: AppRoutes.addExpense.name,
            pageBuilder: (context, state) {
              final amount = state.queryParameters['amount'];
              final description = state.queryParameters['description'];
              return CustomTransitionPage(
                child: AddMovementScreen(
                  type: MovementType.expense,
                  amount: amount,
                  description: description,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ),
                            ),
                            child: child),
              );
            }),
        GoRoute(
            parentNavigatorKey: _rootNavigator,
            path: AppRoutes.add.path,
            name: AppRoutes.add.name,
            pageBuilder: (context, state) => CustomTransitionPage(
                  child: const AddScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          SlideTransition(
                              position: animation.drive(
                                Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ),
                              ),
                              child: child),
                )),
        if (RemoteConfigHandler.instance!.getBudgets())
          GoRoute(
              parentNavigatorKey: _rootNavigator,
              path: AppRoutes.editBudget.path,
              name: AppRoutes.editBudget.name,
              pageBuilder: (context, state) => CustomTransitionPage(
                    child: EditBudgetScreen(id: state.pathParameters['id']!),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            SlideTransition(
                                position: animation.drive(
                                  Tween<Offset>(
                                    begin: const Offset(1, 0),
                                    end: Offset.zero,
                                  ),
                                ),
                                child: child),
                  )),
        ShellRoute(
            navigatorKey: _shellNavigator,
            builder: (context, state, child) => MainLayout(body: child),
            routes: shellRoutes
                .map((route) => GoRoute(
                      path: route.path,
                      name: route.name,
                      pageBuilder: (context, state) =>
                          _getShellPageBuilder(context, state, route),
                    ))
                .toList()),
      ]);
}

Page<dynamic> _getShellPageBuilder(
    BuildContext context, GoRouterState state, AppRoutes route) {
  switch (route) {
    case AppRoutes.home:
      return const NoTransitionPage(child: HomeScreen());
    case AppRoutes.incomes:
      return const NoTransitionPage(child: IncomesScreen());
    case AppRoutes.expenses:
      return const NoTransitionPage(child: ExpensesScreen());
    case AppRoutes.budgets:
      return const NoTransitionPage(child: BudgetsScreen());
    default:
      return const NoTransitionPage(child: ErrorScreen());
  }
}
