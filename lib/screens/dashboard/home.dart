import 'package:flutter/material.dart';
import 'package:yafta/design_system/cells/balance_graph.dart';
import 'package:yafta/design_system/molecules/yafta_segmented_button.dart';

import '../../design_system/cells/balance_card.dart';
import '../../design_system/molecules/pie_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static void _onSelectionChanged(Set<int> idx) {
    print(idx);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YaftaSegmentedButton(onSelectionChanged: _onSelectionChanged),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView(
            children: [
              BalanceCard(
                balance: '1.000,00',
                income: '1.000,00',
                expenses: '1.000,00',
              ),
              SizedBox(
                height: 20,
              ),
              BalanceGraph(),
            ],
          ),
        ),
      ],
    );
  }
}
