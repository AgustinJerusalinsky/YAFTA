import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/yafta_segmented_button.dart';

import '../design_system/cells/balance_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static void _onSelectionChanged(Set<int> idx) {
    print(idx);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 30,
      children: [
        YaftaSegmentedButton(onSelectionChanged: _onSelectionChanged),
        BalanceCard(
          balance: '1.000,00',
          income: '1.000,00',
          expenses: '1.000,00',
        ),
      ],
    );
  }
}
