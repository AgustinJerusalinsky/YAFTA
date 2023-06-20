import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/button.dart';
import 'package:yafta/design_system/molecules/search_bar.dart';
import 'package:yafta/design_system/molecules/text_field.dart';
import 'package:yafta/design_system/molecules/yafta_app_bar.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:yafta/services/category_provider.dart';

const List<DropdownMenuItem> items = [
  DropdownMenuItem(value: MovementType.income, child: Text("Ingreso")),
  DropdownMenuItem(value: MovementType.expense, child: Text("Gasto"))
];

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({Key? key}) : super(key: key);
  @override
  State<AddBudgetScreen> createState() => AddBudgetScreenState();
}

class AddBudgetScreenState extends State<AddBudgetScreen> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  MovementType? dropdownValue;
  final _formKey = GlobalKey<FormState>();
  void _handleSubmit() async {
    //validate form

    if (!_formKey.currentState!.validate()) return;

    final categoryName = _categoryController.text.trim();
    final amount = _amountController.text.trim();

    final MovementType type = dropdownValue!;

    final String userId = context.read<AuthProvider>().user!.uid;
    final response = await context
        .read<CategoryProvider>()
        .addCategory(userId, categoryName, int.parse(amount), type);
    context.pop();
    // Navigate to home without context
  }

  void onChanged(dynamic value) {
    setState(() {
      dropdownValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YaftaAppBar(
        back: true,
        showBrand: true,
      ),
      body: Form(
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
                    label: "Categoria",
                    textController: _categoryController),
                YaftaTextField(
                  validator: (value) =>
                      value.isEmpty ? 'Campo requerido' : null,
                  label: "Monto",
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
                      value: dropdownValue,
                      isExpanded: true,
                      hint: const Text("Tipo de movimiento"),
                      items: items,
                      onChanged: onChanged),
                )
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
      ),
    );
  }
}
