import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/cells/balance_graph.dart';
import 'package:yafta/design_system/cells/budget_ring.dart';
import 'package:yafta/design_system/cells/movement_row.dart';
import 'package:yafta/design_system/molecules/main_layout.dart';
import 'package:yafta/screens/budgets/budgets.dart';
import 'package:yafta/screens/dashboard/home.dart';
import 'package:yafta/screens/expenses/expenses.dart';
import 'package:yafta/screens/incomes/incomes.dart';
import 'package:yafta/services/app_navigation.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:yafta/services/budget_provider.dart';
import 'package:yafta/services/movement_provider.dart';
import 'package:yafta/utils/remote_config.dart';

import '../mocks/firebase_mocks.dart';
import '../mocks/provider_mocks.dart';

MultiProvider customBuilder(child, {bool darkMode = false}) {
  MockAuthProvider mockAuthProvider = MockAuthProvider();
  MockMovementsProvider mockMovementProvider = MockMovementsProvider();
  MockBudgetsProvider mockBudgetsProvider = MockBudgetsProvider(
      authProvider: mockAuthProvider, movementProvider: mockMovementProvider);
  MockAppNavigator mockAppNavigator = MockAppNavigator();

  return MultiProvider(
    providers: [
      ChangeNotifierProvider<MovementProvider>(
        create: (_) => mockMovementProvider,
      ),
      ChangeNotifierProvider<BudgetProvider>(
        create: (_) => mockBudgetsProvider,
      ),
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => mockAuthProvider,
      ),
      ChangeNotifierProvider<AppNavigation>(
        create: (_) => mockAppNavigator,
      ),
    ],
    child: MaterialApp(home: child),
  );
}

void main() {
  RemoteConfigHandler.instance = FakeRemoteConfigHandler();
  testWidgets("Check if budgets are being rendered", (widgetTester) async {
    await widgetTester.pumpWidget(customBuilder(const MainLayout(
      body: BudgetsScreen(),
    )));
    final budgets = find.byType(BudgetRing);
    expect(budgets, findsWidgets);
  });

  testWidgets("Test if expenses are being rendered", (widgetTester) async {
    await widgetTester.pumpWidget(customBuilder(const MainLayout(
      body: ExpensesScreen(),
    )));
    final movements = find.byType(MovementRow);
    expect(movements, findsWidgets);
  });

  testWidgets("Test if incomes are being rendered", (widgetTester) async {
    await widgetTester.pumpWidget(customBuilder(const MainLayout(
      body: IncomesScreen(),
    )));
    final movements = find.byType(MovementRow);
    expect(movements, findsOneWidget);
  });

  testWidgets("Test if graphs are being rendered", (WidgetTester) async {
    await WidgetTester.pumpWidget(customBuilder(const MainLayout(
      body: HomeScreen(),
    )));
    final graphs = find.byType(BalanceGraph);
    expect(graphs, findsOneWidget);
  });
}
