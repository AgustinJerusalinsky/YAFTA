import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yafta/design_system/cells/categories_search.dart';
import 'package:yafta/design_system/cells/movement_row.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';

class MovementScreen extends StatefulWidget {
  const MovementScreen({Key? key, required this.movements, required this.type})
      : super(key: key);
  final List<Movement> movements;
  final MovementType type;
  @override
  _MovementScreenState createState() => _MovementScreenState();
}

class _MovementScreenState extends State<MovementScreen> {
  List<String> selectedCategories = [];
  List<Movement> filteredMovements = [];

  void filterMovements() {
    if (selectedCategories.isEmpty) {
      setState(() {
        filteredMovements = List.from(widget.movements);
      });
    } else {
      setState(() {
        filteredMovements = widget.movements
            .where((movement) => selectedCategories.contains(movement.category))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    filteredMovements = List.from(widget.movements);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoriesSearchBar(
          onSelectedItemsChange: (selectedCategories) {
            setState(() {
              this.selectedCategories = selectedCategories;
              filterMovements();
            });
          },
        ),
        SizedBox(height: 16),
        ListTile(
          title: Text(
            "Total",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          trailing: Text(
            "${widget.type == MovementType.income ? "+" : "-"}\$${filteredMovements.fold(0, (total, movement) => total + movement.amount)}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          tileColor: Theme.of(context).colorScheme.tertiaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              height: 1,
              thickness: 1,
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
            itemCount: filteredMovements.length,
            itemBuilder: (context, index) {
              return MovementRow(movement: filteredMovements[index]);
            },
          ),
        ),
      ],
    );
  }
}
