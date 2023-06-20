import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/yafta_card.dart';
import 'package:yafta/utils/text.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    Key? key,
    required this.total,
    required this.income,
    required this.expenses,
    required this.loadingExpenses,
    required this.loadingIncomes,
  }) : super(key: key);

  final String total;
  final String income;
  final String expenses;
  final bool loadingExpenses;
  final bool loadingIncomes;

  @override
  Widget build(BuildContext context) {
    return YaftaCard(
      mainSection: Wrap(
        runSpacing: 12,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                (loadingExpenses || loadingIncomes)
                    ? const Padding(
                        padding: EdgeInsets.only(right: 75.0),
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        '\$ ' + total,
                        style: TextStyle(
                            fontSize: getTextSizeBig(total),
                            fontWeight: FontWeight.w700),
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    loadingIncomes
                        ? CircularProgressIndicator()
                        : Text(
                            income,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: getTextSize(income),
                                fontWeight: FontWeight.w400),
                          ),
                    Text(
                      "Ingresos",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium!.fontSize,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                //Separator
                Container(
                  height: 44,
                  width: 1,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    loadingExpenses
                        ? CircularProgressIndicator()
                        : Text(
                            expenses,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: getTextSize(expenses),
                                fontWeight: FontWeight.w400),
                          ),
                    Text(
                      "Gastos",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium!.fontSize,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
