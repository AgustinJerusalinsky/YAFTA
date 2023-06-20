import 'package:flutter/material.dart';

class YaftaSearchBar extends StatefulWidget {
  final List<String> items;
  final String label;
  final String emptyLabel;
  final Function(List<String>) onSelectedItemsChange;
  final bool loading;

  const YaftaSearchBar(
      {Key? key,
      required this.items,
      required this.label,
      required this.onSelectedItemsChange,
      required this.loading,
      required this.emptyLabel})
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
        ListTile(
          tileColor: Theme.of(context).colorScheme.surfaceVariant,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: Text(widget.label),
          trailing: IconButton(
            icon: Icon(Icons.search),
            onPressed: openModal,
          ),
          leading: Icon(Icons.menu),
          onTap: openModal,
        ),
        SizedBox(height: 16),
        selectedItems.length > 0
            ? Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                      spacing: 5,
                      children: selectedItems.map((item) {
                        return Chip(
                          side: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          label: Text(item,
                              style: Theme.of(context).textTheme.bodyMedium),
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
                  padding: EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.emptyLabel,
                      style: Theme.of(context).textTheme.bodyMedium,
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
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                      title: Text(item),
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
            child: Text('Volver'),
          ),
        ],
      ),
    );
  }
}
