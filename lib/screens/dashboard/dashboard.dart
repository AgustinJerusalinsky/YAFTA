import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/main_layout.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(body: Container(color: Colors.red));
  }
}
