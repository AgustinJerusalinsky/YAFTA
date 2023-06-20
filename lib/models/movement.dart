import 'package:yafta/models/category.dart';

import 'movement_type.dart';

class Movement {
  final int amount;
  final Category category;
  final MovementType type;
  String? description;
  DateTime? date;

  Movement({
    required this.amount,
    required this.category,
    required this.type,
    this.description = '',
    this.date,
  });

  //add toMap and fromMap methods
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': {
        'name': category.name,
        'category_id': category.categoryId,
      },
      'type': type.toString(),
      'description': description,
      'date': date,
    };
  }

  factory Movement.fromMap(Map<String, dynamic> map) {
    return Movement(
      amount: map['amount'],
      category: Category.fromMap(map['category']),
      type: MovementType.values.firstWhere((e) => e.toString() == map['type']),
      date: map['date'],
    );
  }
}
