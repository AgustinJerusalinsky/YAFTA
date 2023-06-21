import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/main_layout.dart';
import 'package:yafta/screens/budgets/budgets.dart';
import 'package:yafta/screens/dashboard/home.dart';
import 'package:yafta/screens/incomes/incomes.dart';
import 'package:yafta/services/app_navigation.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:yafta/services/budget_provider.dart';
import 'package:yafta/services/movement_provider.dart';
import 'package:yafta/utils/remote_config.dart';

import 'firebase_mocks.dart';
import 'provider_mocks.dart';

MultiProvider customBuilder(child) {
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
    child: child,
  );
}

void main() async {
  RemoteConfigHandler.instance = FakeRemoteConfigHandler();
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
          widget: customBuilder(const MainLayout(body: BudgetsScreen())),
          name: 'budgets_screen');

    await tester.pumpDeviceBuilder(deviceBuilder);

    await screenMatchesGolden(tester, 'goldens');
  });
}
