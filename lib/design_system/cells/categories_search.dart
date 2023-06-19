import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/search_bar.dart';

const List<String> items = [
  "Alquiler",
  "Sueldo",
  "Comida",
  "Transporte",
  "Servicios",
  "Ropa",
  "Salud",
  "Educación",
  "Entretenimiento",
  "Otros"
];

class CategoriesSearchBar extends StatelessWidget {
  const CategoriesSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      label: "Categorías",
      items: items,
      onSelectedItemsChange: (items) {
        print(items);
      },
    );
  }
}
