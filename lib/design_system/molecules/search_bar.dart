import 'package:flutter/material.dart';

class YaftaSearchBar extends StatefulWidget {
  final List<String> items;
  final String label;
  final String emptyLabel;
  final Function(List<String>) onSelectedItemsChange;
  final List<String> filterOptions;
  final Function(String) onFilterChange;
  final String selectedFilter;
  final bool loading;

  const YaftaSearchBar(
      {Key? key,
      required this.items,
      required this.label,
      required this.onSelectedItemsChange,
      required this.loading,
      required this.emptyLabel,
      required this.filterOptions,
      required this.onFilterChange,
      required this.selectedFilter})
      : super(key: key);

  @override
  YaftaSearchBarState createState() => YaftaSearchBarState();
}

class YaftaSearchBarState extends State<YaftaSearchBar> {
  List<String> selectedItems = [];

  void openModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogContent(
          loading: widget.loading,
          allItems: widget.items,
          selectedItems: selectedItems,
          onItemTapped: (item) {
            setState(() {
              final isSelected = selectedItems.contains(item);
              if (!isSelected) {
                selectedItems.add(item);
                widget.onSelectedItemsChange(selectedItems);
              }
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                tileColor: Theme.of(context).colorScheme.surfaceVariant,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                title: Text(
                  widget.label,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                leading: Icon(Icons.menu,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
                onTap: openModal,
              ),
            ),
            PopupMenuButton(
                onSelected: widget.onFilterChange,
                initialValue: widget.selectedFilter,
                itemBuilder: (context) {
                  return widget.filterOptions.map((option) {
                    return PopupMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList();
                },
                position: PopupMenuPosition.under,
                icon: Icon(Icons.filter_list,
                    color: Theme.of(context).colorScheme.onSurface))
          ],
        ),
        const SizedBox(height: 16),
        selectedItems.isNotEmpty
            ? Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                      spacing: 5,
                      children: selectedItems.map((item) {
                        return Chip(
                          deleteIconColor: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          side: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          label: Text(item,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer)),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          onDeleted: () {
                            setState(() {
                              selectedItems.remove(item);
                              widget.onSelectedItemsChange(selectedItems);
                            });
                          },
                        );
                      }).toList()),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.emptyLabel,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

class DialogContent extends StatefulWidget {
  final List<String> allItems;
  final List<String> selectedItems;
  final Function(String) onItemTapped;
  final bool loading;

  const DialogContent({
    Key? key,
    required this.allItems,
    required this.selectedItems,
    required this.onItemTapped,
    required this.loading,
  }) : super(key: key);

  @override
  DialogContentState createState() => DialogContentState();
}

class DialogContentState extends State<DialogContent> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.loading
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.allItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = widget.allItems[index];

                    return ListTile(
                      title: Text(
                        item,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                      trailing: Icon(
                        widget.selectedItems.contains(item)
                            ? Icons.check
                            : Icons.add,
                        color: widget.selectedItems.contains(item)
                            ? Colors.green
                            : null,
                      ),
                      onTap: () {
                        widget.onItemTapped(item);
                      },
                    );
                  },
                ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Volver',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
