import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/design_system.dart';
import 'package:yafta/screens/auth/login.dart';
import 'package:yafta/services/app_navigation.dart';

import 'design_system/atoms/yafta_logo.dart';
import 'screens/auth/signup.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppNavigation(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(routes: {
    '/auth/login': (context, state, data) => const LoginScreen(),
    '/auth/signup': (context, state, data) => const SignupScreen(),
    '/home': (context, state, data) =>
        const MyHomePage(title: 'Home', backgroundColor: Colors.green),
    '/incomes': (context, state, data) =>
        const MyHomePage(title: 'Incomes', backgroundColor: Colors.red),
    '/expenses': (context, state, data) =>
        const MyHomePage(title: 'Expenses', backgroundColor: Colors.blue),
  }));

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

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key, required this.title, required this.backgroundColor});
  final String title;
  final Color backgroundColor;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onDestinationSelected(Set<int> n) {}

  @override
  Widget build(BuildContext context) {
    final appNavigation = Provider.of<AppNavigation>(context);
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: YaftaNavigationBar(),
      body: Column(children: [
        YaftaSegmentedButton(
          onSelectionChanged: (Set<int> idx) => print(idx),
        ),
        const YaftaLogo.isologo()
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
