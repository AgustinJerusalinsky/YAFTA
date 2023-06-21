import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/yafta_app_bar.dart';
import 'package:yafta/design_system/molecules/yafta_navigation_bar.dart';
import 'package:yafta/routing/router_utils.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:yafta/services/movement_provider.dart';

import '../../services/app_navigation.dart';
import '../../utils/analytics.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key, required this.body}) : super(key: key);
  final Widget body;
  @override
  Widget build(BuildContext context) {
    final appNavigation = Provider.of<AppNavigation>(context);

    return Scaffold(
      appBar: YaftaAppBar(
        title:
            "${AppNavigation.navigationItems[appNavigation.currentIndex]["label"]}",
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
        child: body,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        onPressed: () {
          context.push(AppNavigation.navigationItems[appNavigation.currentIndex]
              ["fabRoute"]);
          // context.go(
          //     "${AppNavigation.navigationItems[appNavigation.currentIndex]["fabRoute"]}");
        },
        icon: Icon(Icons.add,
            color: Theme.of(context).colorScheme.onTertiaryContainer),
        label: Text(
            "${AppNavigation.navigationItems[appNavigation.currentIndex]["fabLabel"]}",
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                )),
      ),
      bottomNavigationBar: YaftaNavigationBar(
        currentIndex: appNavigation.currentIndex,
        onDestinationSelected: (index) {
          context.go(shellRoutes[index].path);
          appNavigation.currentIndex = index;
        },
      ),
    );
  }
}
