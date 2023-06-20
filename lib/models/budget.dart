import 'package:yafta/models/category.dart';

class Budget {
  final Category category;
  final int total;
  int amount;

  Budget({
    required this.category,
    required this.total,
    this.amount = 0,
  });
}
