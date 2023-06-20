import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/tokens/theme_data.dart';
import 'package:yafta/routing/router_provider.dart';
import 'package:yafta/services/app_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yafta/services/budget_provider.dart';
import 'package:yafta/utils/remote_config.dart';
import 'package:yafta/services/movement_provider.dart';
import 'models/user.dart';
import 'services/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await RemoteConfigHandler.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthProvider authProvider;
  late StreamSubscription<User?> authSubscription;

  @override
  void initState() {
    authProvider = AuthProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = AuthProvider();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppNavigation()),
          ChangeNotifierProvider<AuthProvider>(
              create: (context) => authProvider),
          Provider<AppRouter>(create: (context) => AppRouter(authProvider)),
          ChangeNotifierProvider(
              create: (context) => MovementProvider(authProvider)),
          ChangeNotifierProvider(
              create: (context) => BudgetProvider(authProvider))
        ],
        child: Builder(builder: (context) {
          final GoRouter goRouter = Provider.of<AppRouter>(context).router;
          return MaterialApp.router(
            title: 'Yafta',
            theme: RemoteConfigHandler.getTheme() == AppTheme.light
                ? lightTheme
                : lightTheme,
            routerConfig: goRouter,
          );
        }));
  }
}
