import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yafta/design_system/molecules/button.dart';

import '../design_system/molecules/yafta_app_bar.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const YaftaAppBar(
        back: true,
        showBrand: true,
        showProfile: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              YaftaButton(
                text: "Ingreso",
                color: Theme.of(context).colorScheme.primaryContainer,
                textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500),
                onPressed: () => context.pushReplacement('/add/incomes'),
              ),
              const SizedBox(height: 20),
              YaftaButton(
                text: "Gasto",
                variant: "outlined",
                color: Theme.of(context).colorScheme.outline,
                textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500),
                onPressed: () => context.pushReplacement("/add/expenses"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
