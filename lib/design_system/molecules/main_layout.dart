import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
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
          appNavigation.currentIndex = index;
          Beamer.of(context).beamToNamed(appNavigation.currentOptionRoute);
        },
      ),
    );
  }
}
