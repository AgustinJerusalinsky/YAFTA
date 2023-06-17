import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/yafta_navigation_bar.dart';

import '../../services/app_navigation.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key, required this.body}) : super(key: key);
  final Widget body;
  @override
  Widget build(BuildContext context) {
    final appNavigation = Provider.of<AppNavigation>(context);
    return Scaffold(
      body: body,
      bottomNavigationBar: YaftaNavigationBar(
        currentIndex: appNavigation.currentIndex,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              print("go to incomes");
              context.go('/incomes');
              break;
            case 2:
              context.go('/expenses');
              break;
            case 3:
              context.go('/budgets');
              break;
          }
          appNavigation.currentIndex = index;
        },
      ),
    );
  }
}
