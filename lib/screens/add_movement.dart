import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/button.dart';
import 'package:yafta/design_system/molecules/text_field.dart';
import 'package:yafta/design_system/molecules/yafta_app_bar.dart';
import 'package:yafta/design_system/molecules/yafta_overlay_loading.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/services/budget_provider.dart';
import 'package:yafta/services/movement_provider.dart';
import 'package:yafta/utils/remote_config.dart';

import '../utils/analytics.dart';

class AddMovementScreen extends StatefulWidget {
  final MovementType type;
  const AddMovementScreen({Key? key, required this.type}) : super(key: key);
  @override
  State<AddMovementScreen> createState() => AddMovementScreenState();
}

class AddMovementScreenState extends State<AddMovementScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  bool _submitting = false;

  Category? category;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateTime.now().toString().split(' ')[0];
  }

  final _formKey = GlobalKey<FormState>();
  void _handleSubmit() async {
    //validate form
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _submitting = true;
    });

    final description = _descriptionController.text.trim();
    final amount = _amountController.text.trim();
    final date = _dateController.text.trim();

    if (!RemoteConfigHandler.getBudgets()) {
      BudgetProvider budgetProvider = context.read<BudgetProvider>();
      bool categoryExists =
          await budgetProvider.categoryExists(noCategoryName, widget.type);
      if (!categoryExists) {
        category =
            await budgetProvider.addCategory(noCategoryName, 0, widget.type);
      } else {
        category = await budgetProvider.getCategoryByNameAndType(
            noCategoryName, widget.type);
      }
    }

    await context.read<MovementProvider>().addMovement(double.parse(amount),
        category!, description, widget.type, DateTime.parse(date));
    await AnalyticsHandler.logMovement(
        movementType: widget.type, value: double.parse(amount));
    context.pop();

    // Navigate to home without context
  }

  void onChanged(dynamic value) {
    setState(() {
      category = value;
      _submitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      appBar: const YaftaAppBar(
        back: true,
        showBrand: true,
        showProfile: false,
      ),
      body: YaftaOverlayLoading(
        isLoading: _submitting,
        child: Consumer<BudgetProvider>(builder: (context, provider, _) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    YaftaTextField(
                        validator: (value) =>
                            value.isEmpty ? 'Campo requerido' : null,
                        label: "Descripción",
                        textController: _descriptionController),
                    YaftaTextField(
                      validator: (value) =>
                          value.isEmpty ? 'Campo requerido' : null,
                      label: "Valor",
                      textController: _amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    if (RemoteConfigHandler.getBudgets())
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DropdownButtonFormField(
                            validator: (value) =>
                                value == null ? 'Campo requerido' : null,
                            borderRadius: BorderRadius.circular(10),
                            value: category,
                            isExpanded: true,
                            dropdownColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                            hint: Text(
                              "Categoria",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ),
                            items: provider.categories
                                .where((element) =>
                                    element.type == widget.type &&
                                    element.name != noCategoryName)
                                .map((category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface)),
                                    ))
                                .toList(),
                            onChanged: onChanged),
                      ),
                    YaftaTextField(
                      label: "Fecha",
                      textController: _dateController,
                      readOnly: true,
                      validator: (value) =>
                          value.isEmpty ? 'Campo requerido' : null,
                      onTap: () async {
                        final DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          _dateController.text = date.toString().split(' ')[0];
                        }
                      },
                    ),
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: YaftaButton(
                              text: 'Cancelar',
                              fullWidth: true,
                              variant: 'filled',
                              secondary: true,
                              onPressed: () => context.pop(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: YaftaButton(
                              text: 'Guardar',
                              fullWidth: true,
                              variant: 'filled',
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              textStyle: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                              onPressed: _handleSubmit,
                            ),
                          ),
                        )
                      ])
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
