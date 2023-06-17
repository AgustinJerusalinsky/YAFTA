import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/main_layout.dart';
import 'package:yafta/main.dart';

import '../screens/dashboard/dashboard.dart';

final GlobalKey<NavigatorState> _rootNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final router =
    GoRouter(navigatorKey: _rootNavigator, initialLocation: "/", routes: [
  ShellRoute(
    navigatorKey: _shellNavigator,
    builder: (context, state, child) => MainLayout(body: child),
    routes: [
      GoRoute(
        path: "/",
        name: "home",
        pageBuilder: (context, state) => NoTransitionPage(
            child: Container(
          color: Colors.red,
        )),
      ),
      GoRoute(
        path: "/incomes",
        name: "incomes",
        pageBuilder: (context, state) => NoTransitionPage(
            child: Container(
          color: Colors.green,
        )),
      ),
      GoRoute(
        path: "/expenses",
        name: "expenses",
        pageBuilder: (context, state) => NoTransitionPage(
            child: Container(
          color: Colors.blue,
        )),
      ),
      GoRoute(
        path: "/budgets",
        name: "budgets",
        pageBuilder: (context, state) => NoTransitionPage(
            child: Container(
          color: Colors.yellow,
        )),
      ),
    ],
  )
]);
