import 'package:flutter/material.dart';

const navigationItems = [
  {
    "icon": Icons.home_outlined,
    "label": "Inicio",
  },
  {
    "icon": Icons.trending_up,
    "label": "Ingresos",
  },
  {
    "icon": Icons.trending_down,
    "label": "Gastos",
  },
  {"icon": Icons.savings_outlined, "label": "Presupuestos"}
];

class YaftaNavigationBar extends StatefulWidget {
  const YaftaNavigationBar({Key? key, required this.onDestinationSelected})
      : super(key: key);

  final void Function(int n) onDestinationSelected;

  @override
  State<YaftaNavigationBar> createState() => _YaftaNavigationBarState();
}

class _YaftaNavigationBarState extends State<YaftaNavigationBar> {
  int _currentPageIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _currentPageIndex = index;
    });
    widget.onDestinationSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      elevation: 5,
      onDestinationSelected: _onDestinationSelected,
      selectedIndex: _currentPageIndex,
      destinations: navigationItems
          .map((e) => NavigationDestination(
                icon: Icon(
                  e["icon"] as IconData,
                  size: 24,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                label: e["label"] as String,
              ))
          .toList(),
    );
  }
}
