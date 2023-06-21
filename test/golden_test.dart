import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';
import 'package:yafta/data/firestore_service.dart';
import 'package:yafta/design_system/cells/movement_screen.dart';
import 'package:yafta/design_system/molecules/main_layout.dart';
import 'package:yafta/main.dart';
import 'package:yafta/models/budget.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/models/user.dart';
import 'package:yafta/screens/add_movement.dart';
import 'package:yafta/screens/budgets/budgets.dart';
import 'package:yafta/screens/dashboard/home.dart';
import 'package:yafta/screens/incomes/incomes.dart';
import 'package:yafta/services/app_navigation.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:yafta/services/budget_provider.dart';
import 'package:yafta/services/movement_provider.dart';

class MockAuthProvider extends ChangeNotifier implements AuthProvider {
  dynamic _user;
  @override
  Future<User?> login(String email, String password) async {
    _user = User(uid: "testUID", email: email);
    return user;
  }

  @override
  Future<void> logout() async {
    return;
  }

  @override
  Future<User?> signup(String email, String password) {
    return login(email, password);
  }

  @override
  get user => _user;
}

final mockAuthProvider = MockAuthProvider();

//categories
Category education = Category(
    name: "Educacion",
    amount: 150000,
    type: MovementType.expense,
    categoryId: "educationID",
    creationDate: DateTime.now());
Category food = Category(
    name: "Comida",
    amount: 50000,
    type: MovementType.expense,
    categoryId: "foodID",
    creationDate: DateTime.now());
Category salary = Category(
    name: "Salario",
    amount: 250000,
    type: MovementType.income,
    categoryId: "salaryID",
    creationDate: DateTime.now());

//movements
Movement paySchool = Movement(
    amount: 150000,
    category: education,
    type: MovementType.expense,
    description: "Pago de colegiatura",
    id: "schoolID",
    date: DateTime.now());
Movement payFood = Movement(
    amount: 50000,
    category: food,
    type: MovementType.expense,
    description: "Pago de comida",
    id: "foodID",
    date: DateTime.now());
Movement invoiceSalary = Movement(
    amount: 250000,
    category: salary,
    type: MovementType.income,
    description: "Pago de salario",
    id: "salaryID",
    date: DateTime.now());

final mockIncomes = [
  invoiceSalary,
];

final mockExpenses = [
  paySchool,
  payFood,
];

final mockCategories = [
  education,
  food,
  salary,
];

Budget educationBudget = Budget(
  total: 150000,
  amount: 100000,
  category: education,
);

Budget foodBudget = Budget(
  total: 50000,
  amount: 100000,
  category: food,
);

Budget salaryBudget = Budget(
  total: 250000,
  amount: 100000,
  category: salary,
);

final mockBudgets = [
  educationBudget,
  foodBudget,
  salaryBudget,
];

class MockMovementsProvider extends ChangeNotifier implements MovementProvider {
  @override
  bool expensesWeekShouldFetch = false;

  @override
  List<Movement> monthExpenses = mockExpenses;

  @override
  List<Movement> monthIncomes = mockIncomes;

  @override
  List<Movement> totalExpenses = mockExpenses;

  @override
  List<Movement> totalIncomes = mockIncomes;

  @override
  List<Movement> weekExpenses = mockExpenses;

  @override
  List<Movement> weekIncomes = mockIncomes;

  @override
  Future<void> addMovement(double amount, Category category, String description,
      MovementType type, DateTime date) {
    // TODO: implement addMovement
    return Future.value();
  }

  @override
  Future<void> deleteMovement(String userId, String movementId) {
    // TODO: implement deleteMovement
    return Future.value();
  }

  @override
  set expenseDirty(bool value) {
    // TODO: implement expenseDirty
  }

  @override
  set expenseMonthDirty(bool value) {
    // TODO: implement expenseMonthDirty
  }

  @override
  set expenseTotalDirty(bool value) {
    // TODO: implement expenseTotalDirty
  }

  @override
  set expenseWeekDirty(bool value) {
    // TODO: implement expenseWeekDirty
  }

  @override
  // TODO: implement expensesMonthShouldFetch
  bool get expensesMonthShouldFetch => false;

  @override
  // TODO: implement expensesShouldFetch
  bool get expensesShouldFetch => false;

  @override
  // TODO: implement expensesTotalShouldFetch
  bool get expensesTotalShouldFetch => false;

  @override
  set incomeMonthDirty(bool value) {
    // TODO: implement incomeMonthDirty
  }

  @override
  set incomeTotalDirty(bool value) {
    // TODO: implement incomeTotalDirty
  }

  @override
  set incomeWeekDirty(bool value) {
    // TODO: implement incomeWeekDirty
  }

  @override
  // TODO: implement incomesMonthShouldFetch
  bool get incomesMonthShouldFetch => false;

  @override
  // TODO: implement incomesShouldFetch
  bool get incomesShouldFetch => false;

  @override
  // TODO: implement incomesTotalShouldFetch
  bool get incomesTotalShouldFetch => false;

  @override
  // TODO: implement incomesWeekShouldFetch
  bool get incomesWeekShouldFetch => false;

  @override
  set incomeDirty(bool value) {
    // TODO: implement incomeDirty
  }
}

final mockMovementProvider = MockMovementsProvider();

class MockBudgetsProvider extends ChangeNotifier implements BudgetProvider {
  @override
  AuthProvider authProvider = mockAuthProvider;

  @override
  List<Budget> budgets = mockBudgets;

  @override
  List<Category> categories = mockCategories;

  @override
  bool categoriesShouldFetch = false;

  @override
  Future<void> addCategory(String name, double amount, MovementType type) {
    // TODO: implement addCategory
    return Future.value();
  }

  @override
  // TODO: implement budgetsShouldFetch
  bool get budgetsShouldFetch => false;

  @override
  Future<void> deleteCategory(String categoryId) {
    // TODO: implement deleteCategory
    return Future.value();
  }

  @override
  // TODO: implement firestoreService
  FirestoreService get firestoreService => throw UnimplementedError();

  @override
  Future<Category> getCategory(String categoryId) {
    // TODO: implement getCategory
    return Future.value(Category(
        categoryId: "testId",
        name: "testName",
        amount: 100,
        type: MovementType.income));
  }

  @override
  // TODO: implement movementProvider
  MovementProvider get movementProvider => mockMovementProvider;

  @override
  Future<void> updateCategory(String categoryId, String name, double amount) {
    // TODO: implement updateCategory
    return Future.value();
  }

  @override
  set budgetDirty(bool value) {
    // TODO: implement budgetDirty
  }

  @override
  set categoryDirty(bool value) {
    // TODO: implement categoryDirty
  }
}

class MockAppNavigator extends ChangeNotifier implements AppNavigation {
  @override
  int currentIndex = 0;

  @override
  // TODO: implement currentNavigationItem
  get currentNavigationItem => currentIndex;

  @override
  // TODO: implement currentOptionRoute
  String get currentOptionRoute => "testRoute";

  @override
  // TODO: implement currentRoute
  String get currentRoute => "testRoute";
}

MultiProvider customBuilder(child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<MovementProvider>(
        create: (_) => MockMovementsProvider(),
      ),
      ChangeNotifierProvider<BudgetProvider>(
        create: (_) => MockBudgetsProvider(),
      ),
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => MockAuthProvider(),
      ),
      ChangeNotifierProvider<AppNavigation>(
        create: (_) => MockAppNavigator(),
      ),
    ],
    child: child,
  );
}

void main() {
  testGoldens('Test App Goldens', (tester) async {
    DeviceBuilder deviceBuilder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletLandscape,
        Device.tabletPortrait
      ])
      ..addScenario(
        widget: customBuilder(const MainLayout(body: IncomesScreen())),
        name: 'incomes_screen',
      )
      ..addScenario(
          widget: customBuilder(const MainLayout(body: HomeScreen())),
          name: 'home_screen')
      ..addScenario(
          widget: customBuilder(MainLayout(body: BudgetsScreen())),
          name: 'budgets_screen');

    await tester.pumpDeviceBuilder(deviceBuilder);

    await screenMatchesGolden(tester, 'goldens');
  });
}
