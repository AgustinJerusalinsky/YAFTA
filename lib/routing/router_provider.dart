import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yafta/design_system/molecules/button.dart';
import 'package:yafta/design_system/molecules/main_layout.dart';
import 'package:yafta/routing/router_utils.dart';
import 'package:yafta/screens/auth/login.dart';
import 'package:yafta/screens/auth/signup.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:provider/provider.dart';

import '../screens/error_screen.dart';

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
        if (!isLoggedIn && !isGoingToLogin && !isGoingToSignUp) {
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
                .toList())
      ]);
}

Page<dynamic> _getShellPageBuilder(
    BuildContext context, GoRouterState state, AppRoutes route) {
  switch (route) {
    case AppRoutes.home:
      return NoTransitionPage(
          child: Container(
        color: Colors.red,
        child: SizedBox(
            height: 30,
            child: YaftaButton(
              text: "Logout",
              onPressed: () {
                context.read<AuthProvider>().logout();
                // context.go(AppRoutes.login.path);
              },
            )),
      ));
    case AppRoutes.incomes:
      return NoTransitionPage(child: Container(color: Colors.green));
    case AppRoutes.expenses:
      return NoTransitionPage(child: Container(color: Colors.blue));
    case AppRoutes.budgets:
      return NoTransitionPage(child: Container(color: Colors.yellow));
    default:
      return const NoTransitionPage(child: ErrorScreen());
  }
}
