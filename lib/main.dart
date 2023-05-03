import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/design_system.dart';
import 'package:yafta/screens/auth/login.dart';
import 'package:yafta/services/app_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'design_system/atoms/yafta_logo.dart';
import 'design_system/molecules/main_layout.dart';
import 'screens/auth/auth_location.dart';
import 'screens/auth/signup.dart';
import 'services/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppNavigation()),
    ChangeNotifierProvider(create: (context) => AuthProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        AuthLocation(),
        HomeLocation(),
        IncomeLocation(),
        ExpensesLocation(),
        BudgetsLocation(),
      ],
    ),
    //   locationBuilder: RoutesLocationBuilder(routes: {
    // '/auth/login': (context, state, data) => const LoginScreen(),
    // '/auth/signup': (context, state, data) => const SignupScreen(),
    // '/': (context, state, data) => HomeLocation(),
    // '/incomes': (context, state, data) => IncomeLocation(),
    // '/expenses': (context, state, data) => ExpensesLocation(),
    // '/budgets': (context, state, data) => BudgetsLocation(),
    // })
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher:
          BeamerBackButtonDispatcher(delegate: routerDelegate),
      // const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('home'),
        child: MainLayout(body: Container(color: Colors.red)),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/'];
}

class IncomeLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('incomes'),
        child: MainLayout(body: Container(color: Colors.green)),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/incomes'];
}

class ExpensesLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('expenses'),
        child: MainLayout(body: Container(color: Colors.blue)),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/expenses'];
}

class BudgetsLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('budgets'),
        child: MainLayout(body: Container(color: Colors.purple)),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/budgets'];
}
