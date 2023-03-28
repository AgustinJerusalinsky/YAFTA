import 'package:flutter/material.dart';

class YaftaNavigationBar extends StatelessWidget {
  const YaftaNavigationBar({Key? key, required this.onDestinationSelected})
      : super(key: key);

  final void Function(int n) onDestinationSelected;
  final int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        NavigationDestination(
          icon: Icon(Icons.commute),
          label: 'Commute',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.bookmark),
          icon: Icon(Icons.bookmark_border),
          label: 'Saved',
        ),
      ],
    );
  }
}
