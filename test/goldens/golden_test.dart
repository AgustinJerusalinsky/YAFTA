import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/main_layout.dart';
import 'package:yafta/design_system/tokens/colors.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/screens/add_movement.dart';
import 'package:yafta/screens/auth/forgot_password.dart';
import 'package:yafta/screens/auth/login.dart';
import 'package:yafta/screens/auth/signup.dart';
import 'package:yafta/screens/budgets/add_budget.dart';
import 'package:yafta/screens/budgets/budgets.dart';
import 'package:yafta/screens/budgets/edit_budget.dart';
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
      child: MaterialApp(
        theme: darkMode
            ? ThemeData(useMaterial3: true, colorScheme: darkColorScheme)
            : ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        home: child,
      ));
}

void runGoldenTest(String description, String name, widget) {
  testGoldens(description, (tester) async {
    DeviceBuilder deviceBuilder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletLandscape,
        Device.tabletPortrait
      ])
      ..addScenario(widget: customBuilder(widget), name: '$name-light')
      ..addScenario(
          widget: customBuilder(widget, darkMode: true), name: '$name-dark');

    await tester.pumpDeviceBuilder(deviceBuilder);

    await screenMatchesGolden(tester, name);
  });
}

void main() async {
  RemoteConfigHandler.instance = FakeRemoteConfigHandler();

  //login screens
  runGoldenTest("Login Screen", "login_screen", const LoginScreen());
  runGoldenTest("Register Screen", "register_screen", const SignupScreen());
  runGoldenTest("Forgot Password Screen", "forgot_password_screen",
      const ForgotPasswordScreen());

  // shell screens
  runGoldenTest(
      "Home Screen", "home_screem", const MainLayout(body: HomeScreen()));
  runGoldenTest("Budgets Screen", "budgets_screen",
      const MainLayout(body: BudgetsScreen()));
  runGoldenTest("Incomes Screen", "incomes_screen",
      const MainLayout(body: IncomesScreen()));
  runGoldenTest("Expenses Screen", "expenses_screen",
      const MainLayout(body: ExpensesScreen()));

  // add screens
  runGoldenTest("Add Expense Screen", "add_expense_screen",
      const AddMovementScreen(type: MovementType.expense));
  runGoldenTest("Add Income Screen", "add_income_screen",
      const AddMovementScreen(type: MovementType.income));
  runGoldenTest(
      "Add Budget Screen", "add_budget_screen", const AddBudgetScreen());
  runGoldenTest("Edit Budget Screen", "edit_budget_screen",
      const EditBudgetScreen(id: "1"));
}
