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
import 'package:yafta/utils/analytics.dart';

const List<DropdownMenuItem> items = [
  DropdownMenuItem(value: MovementType.income, child: Text("Ingreso")),
  DropdownMenuItem(value: MovementType.expense, child: Text("Gasto"))
];

class EditBudgetScreen extends StatefulWidget {
  final String id;
  const EditBudgetScreen({Key? key, required this.id}) : super(key: key);
  @override
  State<EditBudgetScreen> createState() => EditBudgetScreenState();
}

class EditBudgetScreenState extends State<EditBudgetScreen> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool loading = true;
  final _formKey = GlobalKey<FormState>();
  Category? category;

  void _handleSubmit() async {
    //validate form

    if (!_formKey.currentState!.validate()) return;
    setState(() {
      loading = true;
    });

    final categoryName = _categoryController.text.trim();
    final amount = _amountController.text.trim();

    await context
        .read<BudgetProvider>()
        .updateCategory(widget.id, categoryName, double.parse(amount));
    await AnalyticsHandler.logNewBudget(
        budgetName: categoryName, budgetAmount: amount);
    context.pop();
  }

  void loadCategory() async {
    await context
        .read<BudgetProvider>()
        .getCategory(widget.id)
        .then((value) => setState(() {
              category = value;
              _categoryController.text = value.name;
              _amountController.text = value.amount.toString();
              loading = false;
            }));
  }

  void onChanged(dynamic value) {
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const YaftaAppBar(
        back: true,
        showBrand: true,
      ),
      body: YaftaOverlayLoading(
        isLoading: loading,
        child: Form(
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
                            variant: 'outlined',
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
      ),
    );
  }
}
