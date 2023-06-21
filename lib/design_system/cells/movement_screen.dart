import 'package:flutter/material.dart';
import 'package:yafta/design_system/cells/categories_search.dart';
import 'package:yafta/design_system/cells/movement_row.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/utils/remote_config.dart';

class MovementScreen extends StatefulWidget {
  const MovementScreen(
      {Key? key,
      required this.movements,
      required this.type,
      required this.loading})
      : super(key: key);
  final List<Movement> movements;
  final MovementType type;
  final bool loading;
  @override
  _MovementScreenState createState() => _MovementScreenState();
}

class _MovementScreenState extends State<MovementScreen> {
  List<String> selectedCategories = [];
  List<Movement> filteredMovements = [];
  List<Movement> _movements = [];
  String selectedFilter = filterOptions[0];

  void onSelectedFilterChange(String filter) {
    setState(() {
      selectedFilter = filter;
    });
    filterMovements();
  }

  void filterMovements() {
    final DateTime dateToCompare;
    if (selectedFilter == filterOptions[0]) {
      dateToCompare = DateTime.now().subtract(const Duration(days: 7));
    } else if (selectedFilter == filterOptions[1]) {
      dateToCompare = DateTime(DateTime.now().year, DateTime.now().month);
    } else {
      dateToCompare = DateTime(0);
    }

    if (selectedCategories.isEmpty) {
      setState(() {
        filteredMovements = _movements
            .where((element) => element.date!.isAfter(dateToCompare))
            .toList();
      });
    } else {
      setState(() {
        filteredMovements = _movements
            .where((movement) =>
                selectedCategories.contains(movement.category.name))
            .where((element) => element.date!.isAfter(dateToCompare))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _movements = widget.movements;
    filteredMovements = List.from(_movements);
  }

  @override
  void didUpdateWidget(covariant MovementScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.movements != widget.movements) {
      _movements = widget.movements;
      filterMovements();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (RemoteConfigHandler.getBudgets())
          const SizedBox(
            height: 16,
          ),
        CategoriesSearchBar(
          onFilterChange: onSelectedFilterChange,
          selectedFilter: selectedFilter,
          type: widget.type,
          onSelectedItemsChange: (selectedCategories) {
            setState(() {
              this.selectedCategories = selectedCategories;
              filterMovements();
            });
          },
        ),
        const SizedBox(height: 16),
        ListTile(
          title: Text("Total",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  )),
          trailing: Text(
            "${widget.type == MovementType.income ? "+" : "-"}\$${filteredMovements.fold(0.0, (total, movement) => total + movement.amount)}",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
          ),
          tileColor: Theme.of(context).colorScheme.tertiaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        const SizedBox(height: 16),
        widget.loading
            ? const Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                      ),
                    ),
                  ],
                ),
              )
            : Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 1,
                    color: Theme.of(context).colorScheme.onSurface,
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
