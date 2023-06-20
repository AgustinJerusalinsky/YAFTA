import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/button.dart';
import 'package:yafta/design_system/molecules/text_field.dart';
import 'package:yafta/design_system/molecules/yafta_app_bar.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:yafta/services/budget_provider.dart';
import 'package:yafta/services/movement_provider.dart';

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

  Category? category;

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  void _handleSubmit() async {
    //validate form
    print(_descriptionController.text.trim());
    if (!_formKey.currentState!.validate()) return;

    final description = _descriptionController.text.trim();
    final amount = _amountController.text.trim();
    final date = _dateController.text.trim();

    final String userId = context.read<AuthProvider>().user!.uid;
    await context.read<MovementProvider>().addMovement(
        userId,
        int.parse(amount),
        category!,
        description,
        widget.type,
        DateTime.parse(date));
    context.pop();
    // Navigate to home without context
  }

  void onChanged(dynamic value) {
    setState(() {
      category = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YaftaAppBar(
        back: true,
        showBrand: true,
      ),
      body: Consumer<BudgetProvider>(builder: (context, provider, _) {
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                        validator: (value) =>
                            value == null ? 'Campo requerido' : null,
                        borderRadius: BorderRadius.circular(10),
                        value: category,
                        isExpanded: true,
                        hint: const Text("Categoria"),
                        items: provider.categories
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name),
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
    );
  }
}
