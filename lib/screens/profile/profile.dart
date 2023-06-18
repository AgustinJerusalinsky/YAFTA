import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/yafta_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const YaftaAppBar(
          back: true,
          showBrand: true,
        ),
        Expanded(
          child: Container(
            height: 200,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
