import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yafta/routing/router_provider.dart';
import 'package:yafta/services/app_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/user.dart';
import 'services/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppNavigation()),
          ChangeNotifierProvider<AuthProvider>(
              create: (context) => AuthProvider()),
          Provider<AppRouter>(create: (context) => AppRouter(authProvider)),
        ],
        child: Builder(builder: (context) {
          final GoRouter goRouter = Provider.of<AppRouter>(context).router;
          return MaterialApp.router(
            title: 'Yafta',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routerConfig: goRouter,
          );
        }));
  }
}
