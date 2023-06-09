import 'dart:async';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/tokens/theme_data.dart';
import 'package:yafta/firebase_options.dart';
import 'package:yafta/routing/router_provider.dart';
import 'package:yafta/services/app_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yafta/services/budget_provider.dart';
import 'package:yafta/utils/remote_config.dart';
import 'package:yafta/services/movement_provider.dart';
import 'package:yafta/utils/restart_widget.dart';
import 'models/user.dart';
import 'services/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (await AppTrackingTransparency.trackingAuthorizationStatus ==
      TrackingStatus.authorized) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  await RemoteConfigHandler.initialize();

  runApp(const RestartWidget(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
    MovementProvider movementProvider = MovementProvider(authProvider);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppNavigation()),
          ChangeNotifierProvider<AuthProvider>(
              create: (context) => authProvider),
          Provider<AppRouter>(create: (context) => AppRouter(authProvider)),
          ChangeNotifierProvider(create: (context) => movementProvider),
          ChangeNotifierProvider(
              create: (context) =>
                  BudgetProvider(authProvider, movementProvider))
        ],
        child: Builder(builder: (context) {
          final GoRouter goRouter = Provider.of<AppRouter>(context).router;
          return MaterialApp.router(
            title: 'Yafta',
            theme: context.watch<AuthProvider>().theme == AppTheme.dark
                ? darkTheme
                : lightTheme,
            routerConfig: goRouter,
          );
        }));
  }
}
