import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/services/app_navigation.dart';

class YaftaNavigationBar extends StatelessWidget {
  const YaftaNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appNavigation = Provider.of<AppNavigation>(context);
    final List<Widget> navItems = appNavigation.navigationItems
        .map((e) => NavigationDestination(
              icon: Icon(
                e["icon"] as IconData,
                size: 24,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              label: e["label"] as String,
            ))
        .toList();
    return NavigationBar(
        elevation: 5,
        onDestinationSelected: (int idx) {
          appNavigation.currentIndex = idx;
          Beamer.of(context).beamToNamed(appNavigation.getCurrentRoute());
        },
        selectedIndex: appNavigation.currentIndex,
        destinations: navItems);
  }
}
