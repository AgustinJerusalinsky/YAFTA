import 'package:flutter/material.dart';

import '../../design_system/molecules/main_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Container(color: Colors.red),
    );
  }
}
