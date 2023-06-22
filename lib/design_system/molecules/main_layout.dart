import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/yafta_app_bar.dart';
import 'package:yafta/design_system/molecules/yafta_navigation_bar.dart';
import 'package:yafta/routing/router_utils.dart';
import 'package:yafta/utils/analytics.dart';
import '../../services/app_navigation.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key, required this.body}) : super(key: key);
  final Widget body;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  void _askTrackingPermission() async {
    if (await AppTrackingTransparency.trackingAuthorizationStatus ==
        TrackingStatus.notDetermined) {
      final status =
          await AppTrackingTransparency.requestTrackingAuthorization();
      if (status != TrackingStatus.authorized) {
        AnalyticsHandler.disableAnalytics();
      }
    } else if (await AppTrackingTransparency.trackingAuthorizationStatus ==
        TrackingStatus.denied) {
      AnalyticsHandler.disableAnalytics();
    }
  }

  @override
  void initState() {
    super.initState();
    _askTrackingPermission();
  }

  @override
  Widget build(BuildContext context) {
    final appNavigation = Provider.of<AppNavigation>(context);

    return SafeArea(
      child: Scaffold(
        appBar: YaftaAppBar(
          title:
              "${AppNavigation.navigationItems[appNavigation.currentIndex]["label"]}",
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
          child: widget.body,
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          onPressed: () {
            context.push(AppNavigation
                .navigationItems[appNavigation.currentIndex]["fabRoute"]);
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
      ),
    );
  }
}
