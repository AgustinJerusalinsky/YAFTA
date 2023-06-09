import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/services/app_navigation.dart';

class YaftaNavigationBar extends StatelessWidget {
  const YaftaNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  final int currentIndex;
  final void Function(int) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final appNavigation = Provider.of<AppNavigation>(context);
    final List<Widget> navItems = AppNavigation.navigationItems
        .map((e) => NavigationDestination(
              icon: Icon(
                e["icon"] as IconData,
                size: 24,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              label: e["label"] as String,
            ))
        .toList();
    return NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        elevation: 5,
        onDestinationSelected: onDestinationSelected,
        selectedIndex: appNavigation.currentIndex,
        destinations: navItems);
  }
}
