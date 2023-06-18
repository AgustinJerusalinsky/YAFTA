import 'package:flutter/material.dart';
import 'package:yafta/design_system/cells/balance_graph.dart';
import 'package:yafta/design_system/molecules/yafta_segmented_button.dart';

import '../../design_system/cells/balance_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static void _onSelectionChanged(Set<int> idx) {
    print(idx);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const YaftaSegmentedButton(onSelectionChanged: _onSelectionChanged),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView(
            children: [
              const BalanceCard(
                total: '0,00',
                income: '\$ 3.000,00',
                expenses: '\$ 3.000,00',
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Categorias",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              const BalanceGraph(
                expensedData: {
                  "Supermercado": 1000,
                  "Transporte": 1000,
                  "Ocio": 1000,
                },
                incomeData: {
                  "Nómina": 1000,
                  "Intereses": 1000,
                  "Otros": 1000,
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
